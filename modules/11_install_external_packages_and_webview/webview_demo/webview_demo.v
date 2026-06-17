module main

import ttytm.webview

const html = '
<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background: linear-gradient(135deg, #1e1e2f 0%, #111119 100%);
            color: #f8f8f2;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            user-select: none;
        }
        .container {
            text-align: center;
            background: rgba(255, 255, 255, 0.05);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(4px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        h1 {
            margin-bottom: 20px;
            font-size: 2.2rem;
            color: #50fa7b;
        }
        input {
            padding: 10px 15px;
            font-size: 1rem;
            border-radius: 6px;
            border: 1px solid #6272a4;
            background-color: #282a36;
            color: #f8f8f2;
            margin-right: 10px;
            outline: none;
        }
        button {
            padding: 10px 20px;
            font-size: 1rem;
            font-weight: bold;
            color: #282a36;
            background-color: #50fa7b;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        button:hover {
            background-color: #8be9fd;
            transform: translateY(-1px);
        }
        #result {
            margin-top: 25px;
            font-size: 1.1rem;
            min-height: 25px;
            color: #f1fa8c;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>V + Webview Binding</h1>
        <input type="text" id="userInput" placeholder="Enter message for V..." value="Hello from JS!">
        <button onclick="sendToV()">Send to V</button>
        <div id="result">Waiting for action...</div>
    </div>

    <script>
        async function sendToV() {
            const input = document.getElementById("userInput").value;
            const resultDiv = document.getElementById("result");
            resultDiv.innerText = "Calling V function...";
            try {
                // Call the bound V function "greet_from_v" asynchronously
                const res = await window.greet_from_v(input);
                resultDiv.innerText = res;
            } catch (err) {
                resultDiv.innerText = "Error: " + err;
            }
        }
    </script>
</body>
</html>
'

// V binding function. Must take &webview.Event and can return a type (like string).
fn greet_from_v(e &webview.Event) string {
    // 1. Retrieve the argument passed from JavaScript (at index 0)
    msg := e.get_arg[string](0) or { 'No arguments passed' }
    println('V side: Received from JS: ${msg}')

    // 2. We can run custom JavaScript on the webview page from V
    e.eval('console.log("V successfully invoked eval in JS context!");')

    // 3. Return string back to the JS Promise resolver
    return 'V responds: "Message received: ${msg}"'
}

fn main() {
    // Initialize Webview
    mut w := webview.create(debug: true)
    w.set_title('V Webview Binding Demo')
    w.set_size(600, 450, .@none)

    // Bind V function "greet_from_v" to JS window.greet_from_v
    w.bind('greet_from_v', greet_from_v)

    // Load the HTML content
    w.set_html(html)

    // Run the main loop
    w.run()
}
