package src


Dense_Pool :: struct($T: typeid, $N: int) {
	elements: [N]T,
	count:    int,
}


delete :: proc(pool: ^Dense_Pool($T, $N), index: int) {
	when ODIN_DEBUG {
		if index < 0 || index >= pool.count {
			return
		}
	}
	last_index := pool.count - 1
	pool.elements[index] = pool.elements[last_index]
	pool.elements[last_index] = {}
	pool.count -= 1
}

allocate :: proc(pool: ^Dense_Pool($T, $N)) -> ^T {
	when ODIN_DEBUG {
		if pool.count >= len(pool.elements) {
			return nil
		}
	}
    index := pool.count
	pool.count += 1
	return &pool.elements[index]
}

slice :: proc(pool: ^Dense_Pool($T, $N)) -> []T {
	return pool.elements[:pool.count]
}
