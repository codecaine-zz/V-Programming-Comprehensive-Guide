import os
import subprocess
import time
import sys


def get_window_rect_for_pid(target_pid, binary_name):
    try:
        result = subprocess.run(["./list_windows"], capture_output=True, text=True)
        if result.returncode != 0:
            return None

        # We look for a line with PID first
        # Format is PID: <pid> | Owner: <owner> | Window: <window> | ID: <id> | Rect: x,y,w,h
        candidates = []
        for line in result.stdout.splitlines():
            if not line.strip():
                continue
            parts = line.split("|")
            if len(parts) >= 5:
                pid_part = parts[0].strip()
                owner_part = parts[1].strip()
                window_part = parts[2].strip()
                rect_part = parts[4].strip()

                try:
                    pid_val = int(pid_part.replace("PID:", "").strip())
                    owner_val = owner_part.replace("Owner:", "").strip()
                    rect_str = rect_part.replace("Rect:", "").strip()

                    # Also collect candidates by name just in case of pid mismatching or sub-processes
                    if pid_val == target_pid:
                        candidates.append((rect_str, window_part))
                    elif binary_name.lower() in owner_val.lower():
                        candidates.append((rect_str, window_part))
                except ValueError:
                    continue

        if candidates:
            # Prefer the one with non-empty window title or just the first one
            for rect, win_title in candidates:
                if (
                    "Window:" in win_title
                    and len(win_title.replace("Window:", "").strip()) > 0
                ):
                    return rect
            return candidates[0][0]
    except Exception as e:
        print(f"Error getting window rect: {e}")
    return None


def main():
    # Compile list_windows tool
    print("Compiling list_windows helper...")
    subprocess.run(
        [
            "clang",
            "-framework",
            "Cocoa",
            "-framework",
            "CoreGraphics",
            "list_windows.m",
            "-o",
            "list_windows",
        ]
    )

    if not os.path.exists("list_windows"):
        print("Could not build list_windows tool")
        sys.exit(1)

    os.makedirs("screenshots", exist_ok=True)

    # Get all .v files in demos/
    demo_dir = "demos"
    if len(sys.argv) > 1:
        arg = sys.argv[1]
        if not arg.endswith(".v"):
            arg = arg + ".v"
        filename = os.path.basename(arg)
        all_files = [filename]
    else:
        all_files = [f for f in os.listdir(demo_dir) if f.endswith(".v")]
        all_files.sort()

    print(f"Found {len(all_files)} demos to process.")

    for filename in all_files:
        demo_path = os.path.join(demo_dir, filename)
        basename = filename[:-2]  # Remove .v

        print(f"\n--- Processing: {basename} ---")

        # Compile
        print(f"Compiling {demo_path}...")
        comp_res = subprocess.run(["v", "-o", basename, demo_path])
        if comp_res.returncode != 0:
            print(f"Compilation failed for {basename}")
            continue

        if not os.path.exists(basename):
            print(f"Executable not found for {basename}")
            continue

        # Run
        print(f"Launching {basename}...")
        proc = subprocess.Popen([f"./{basename}"])

        # Wait for the UI to spawn and display
        time.sleep(2.0)

        # Retrieve window rect
        rect = get_window_rect_for_pid(proc.pid, basename)
        if rect:
            print(f"Found Window Rect: {rect} for {basename}")
            screenshot_path = f"screenshots/{basename}.png"

            # Capture using rect
            # Syntax: screencapture -R x,y,w,h
            print(f"Capturing screenshot to {screenshot_path}...")
            subprocess.run(["screencapture", "-x", "-R", rect, screenshot_path])

            # Quick check if file is created
            if os.path.exists(screenshot_path):
                print(f"Success! Captured {screenshot_path}")
            else:
                print(f"Failed to create screenshot file for {basename}")
        else:
            print(f"Could not locate active window for {basename} with PID {proc.pid}")

        # Terminate
        print(f"Killing {basename}...")
        proc.terminate()
        try:
            proc.wait(timeout=2)
        except subprocess.TimeoutExpired:
            proc.kill()

        # Clean up binary
        if os.path.exists(basename):
            os.remove(basename)


if __name__ == "__main__":
    main()
