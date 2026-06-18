module main

import xiusin.vredis

// NamespacedRedis wraps a standard vredis.Redis client and prefixes all keys with a namespace.
// This simplifies multi-tenant or multi-app key separation.
struct NamespacedRedis {
mut:
	client &vredis.Redis
pub:
	namespace string
}

// new_namespaced_redis creates a new NamespacedRedis helper wrapper.
fn new_namespaced_redis(client &vredis.Redis, namespace string) NamespacedRedis {
	return NamespacedRedis{
		client: client
		namespace: namespace
	}
}

// key constructs the final namespaced key.
// E.g. key('mykey') -> 'app1:mykey'
fn (nr NamespacedRedis) key(name string) string {
	if nr.namespace == '' {
		return name
	}
	return '${nr.namespace}:${name}'
}

// close closes the connection to the Redis server.
fn (mut nr NamespacedRedis) close() ! {
	nr.client.close()!
}

// --- String Operations ---

// set sets a key to a string value.
fn (mut nr NamespacedRedis) set(key string, val string) ! {
	nr.client.set(nr.key(key), val)!
}

// get retrieves a string value by key.
fn (mut nr NamespacedRedis) get(key string) !string {
	return nr.client.get(nr.key(key))!
}

// incr increments a numeric key.
fn (mut nr NamespacedRedis) incr(key string) ! {
	nr.client.incr(nr.key(key))!
}

// expire sets an expiration time (TTL) in seconds on a key.
fn (mut nr NamespacedRedis) expire(key string, seconds int) ! {
	nr.client.expire(nr.key(key), seconds)!
}

// ttl returns the remaining Time-To-Live of a key.
fn (mut nr NamespacedRedis) ttl(key string) !int {
	return nr.client.ttl(nr.key(key))!
}

// del deletes a key.
fn (mut nr NamespacedRedis) del(key string) ! {
	nr.client.del(nr.key(key))!
}

// --- List Operations ---

// rpush appends a value to a list.
fn (mut nr NamespacedRedis) rpush(key string, val string) ! {
	nr.client.rpush(nr.key(key), val)!
}

// lrange retrieves a range of elements from a list.
fn (mut nr NamespacedRedis) lrange(key string, start int, stop int) ![]string {
	return nr.client.lrange(nr.key(key), start, stop)!
}

// lpop removes and returns the first element of a list.
fn (mut nr NamespacedRedis) lpop(key string) !string {
	return nr.client.lpop(nr.key(key))!
}

// llen returns the length of a list.
fn (mut nr NamespacedRedis) llen(key string) !int {
	return nr.client.llen(nr.key(key))!
}

// --- Hash Operations ---

// hset sets a field in a hash to a value.
fn (mut nr NamespacedRedis) hset(key string, field string, val string) ! {
	nr.client.hset(nr.key(key), field, val)!
}

// hget retrieves a field's value from a hash.
fn (mut nr NamespacedRedis) hget(key string, field string) !string {
	return nr.client.hget(nr.key(key), field)!
}

// hgetall retrieves all fields and values of a hash.
fn (mut nr NamespacedRedis) hgetall(key string) !map[string]string {
	return nr.client.hgetall(nr.key(key))!
}

// --- Set Operations ---

// sadd adds a member to a set.
fn (mut nr NamespacedRedis) sadd(key string, member string) ! {
	nr.client.sadd(nr.key(key), member)!
}

// sismember checks if a member belongs to a set.
fn (mut nr NamespacedRedis) sismember(key string, member string) !bool {
	return nr.client.sismember(nr.key(key), member)!
}

// smembers returns all members of a set.
fn (mut nr NamespacedRedis) smembers(key string) ![]string {
	return nr.client.smembers(nr.key(key))!
}
