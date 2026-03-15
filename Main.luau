--!strict
--!native
--!optimize 2
local crypt: (msg: buffer, key: buffer) -> buffer = @native function(msg: buffer, key: buffer): buffer
	local msg_len: number = buffer.len(msg);
	local result: buffer = buffer.create(msg_len);
	local rounds: number = 2;
	local key_len: number = buffer.len(key);
	local z: buffer = buffer.create(120);
	local x: buffer  = buffer.create(120);
	local hash_1: buffer = buffer.create(msg_len+70+100);
	local hash_2: buffer = buffer.create(key_len+70+100);
	buffer.copy(hash_2, 0, key, 0, key_len);
	local offset: number = 0;
	while (offset < msg_len) do
		for i: number = 1, 20 do
			i -= 1;
			local value: number = buffer.readu32(hash_2, (i * 2));
			buffer.writeu32(x, (i * 3), value);
			buffer.writeu32(z, (i * 3), value);
		end;
		for i: number = 1, (rounds) do
			local y0: number, y1: number, y2: number, y3: number
			y0, y1, y2, y3 = buffer.readu32(x, (0 * 4)),buffer.readu32(x, (4 * 4)),buffer.readu32(x, (8 * 4)),buffer.readu32(x, (12 * 4)) :: number;
			do
				local read_x: number = buffer.readu32(x, (i-1));
				read_x += bit32.rshift(buffer.readu32(x, 2), 16) :: number;
				read_x += bit32.rshift(buffer.readu32(x, 4), 16) :: number;
				read_x += bit32.rshift(buffer.readu32(x, 5), 24) :: number;
				buffer.writeu32(x, (i-1), read_x);
				read_x = nil :: never;
				local read_z: number = buffer.readu32(z, (i-1));
				read_z += bit32.rshift(buffer.readu32(z, 2), 16) :: number;
				read_z += bit32.rshift(buffer.readu32(z, 3), 16) :: number;
				read_z += bit32.rshift(buffer.readu32(z, 4), 24) :: number;
				buffer.writeu32(z, (i-1), read_z);
				read_z = nil :: never;
			end;
			do
				y1 = bit32.bxor(y1, bit32.lrotate(y0 + y3, 7)) :: number;
				y2 = bit32.bxor(y2, bit32.lrotate(y1 + y0, 9)) :: number;
				y3 = bit32.bxor(y3, bit32.lrotate(y2 + y1, 13)) :: number;
				y0 = bit32.bxor(y0, bit32.lrotate(y3 + y2, 18)) :: number;
			end;
			buffer.writeu32(x, (0 * 4), y0);
			buffer.writeu32(x, (4 * 4), y1);
			buffer.writeu32(x, (8 * 4), y2);
			buffer.writeu32(x, (12 * 4), y3);
			y0, y1, y2, y3 = buffer.readu32(x, (5 * 4)),buffer.readu32(x, (9 * 4)),buffer.readu32(x, (13 * 4)),buffer.readu32(x, (1 * 4)) :: number;
			do
				y1 = bit32.bxor(y1, bit32.lrotate(y0 + y3, 7)) :: number;
				y2 = bit32.bxor(y2, bit32.lrotate(y1 + y0, 9)) :: number;
				y3 = bit32.bxor(y3, bit32.lrotate(y2 + y1, 13)) :: number;
				y0 = bit32.bxor(y0, bit32.lrotate(y3 + y2, 18)) :: number;
			end;
			buffer.writeu32(x, (5 * 4), y0);
			buffer.writeu32(x, (9 * 4), y1);
			buffer.writeu32(x, (13 * 4), y2);
			buffer.writeu32(x, (1 * 4), y3);
			y0, y1, y2, y3 = buffer.readu32(x, (10 * 4)),buffer.readu32(x, (14 * 4)),buffer.readu32(x, (2 * 4)),buffer.readu32(x, (6 * 4)) :: number;
			do
				y1 = bit32.bxor(y1, bit32.lrotate(y0 + y3, 7)) :: number;
				y2 = bit32.bxor(y2, bit32.lrotate(y1 + y0, 9)) :: number;
				y3 = bit32.bxor(y3, bit32.lrotate(y2 + y1, 13)) :: number;
				y0 = bit32.bxor(y0, bit32.lrotate(y3 + y2, 18)) :: number;
			end;
			buffer.writeu32(x, (10 * 4), y0);
			buffer.writeu32(x, (14 * 4), y1);
			buffer.writeu32(x, (2 * 4), y2);
			buffer.writeu32(x, (6 * 4), y3);
			y0, y1, y2, y3 = buffer.readu32(x, (15 * 4)),buffer.readu32(x, (3 * 4)),buffer.readu32(x, (7 * 4)),buffer.readu32(x, (11 * 4)) :: number;
			do
				y1 = bit32.bxor(y1, bit32.lrotate(y0 + y3, 7)) :: number;
				y2 = bit32.bxor(y2, bit32.lrotate(y1 + y0, 9)) :: number;
				y3 = bit32.bxor(y3, bit32.lrotate(y2 + y1, 13)) :: number;
				y0 = bit32.bxor(y0, bit32.lrotate(y3 + y2, 18)) :: number;
			end;
			buffer.writeu32(x, (15 * 4), y0);
			buffer.writeu32(x, (3 * 4), y1);
			buffer.writeu32(x, (7 * 4), y2);
			buffer.writeu32(x, (11 * 4), y3);
			y0, y1, y2, y3 = buffer.readu32(x, (0 * 4)),buffer.readu32(x, (1 * 4)),buffer.readu32(x, (2 * 4)),buffer.readu32(x, (3 * 4)) :: number;
			do
				y1 = bit32.bxor(y1, bit32.lrotate(y0 + y3, 7)) :: number;
				y2 = bit32.bxor(y2, bit32.lrotate(y1 + y0, 9)) :: number;
				y3 = bit32.bxor(y3, bit32.lrotate(y2 + y1, 13)) :: number;
				y0 = bit32.bxor(y0, bit32.lrotate(y3 + y2, 18)) :: number;
			end;
			buffer.writeu32(x, (0 * 4), y0);
			buffer.writeu32(x, (1 * 4), y1);
			buffer.writeu32(x, (2 * 4), y2);
			buffer.writeu32(x, (3 * 4), y3);
			y0, y1, y2, y3 = buffer.readu32(x, (5 * 4)),buffer.readu32(x, (6 * 4)),buffer.readu32(x, (7 * 4)),buffer.readu32(x, (4 * 4)) :: number;
			do
				y1 = bit32.bxor(y1, bit32.lrotate(y0 + y3, 7)):: number;
				y2 = bit32.bxor(y2, bit32.lrotate(y1 + y0, 9)) :: number;
				y3 = bit32.bxor(y3, bit32.lrotate(y2 + y1, 13)):: number;
				y0 = bit32.bxor(y0, bit32.lrotate(y3 + y2, 18)):: number;
			end;
			buffer.writeu32(x, (5 * 4), y0);
			buffer.writeu32(x, (6 * 4), y1);
			buffer.writeu32(x, (7 * 4), y2);
			buffer.writeu32(x, (4 * 4), y3);
			y0, y1, y2, y3 = buffer.readu32(x, (10 * 4)),buffer.readu32(x, (11 * 4)),buffer.readu32(x, (8 * 4)),buffer.readu32(x, (9 * 4)) :: number;
			do
				y1 = bit32.bxor(y1, bit32.lrotate(y0 + y3, 7)) :: number;
				y2 = bit32.bxor(y2, bit32.lrotate(y1 + y0, 9)) :: number;
				y3 = bit32.bxor(y3, bit32.lrotate(y2 + y1, 13)) :: number;
				y0 = bit32.bxor(y0, bit32.lrotate(y3 + y2, 18)) :: number;
			end;
			buffer.writeu32(x, (10 * 4), y0);
			buffer.writeu32(x, (11 * 4), y1);
			buffer.writeu32(x, (8 * 4), y2);
			buffer.writeu32(x, (9 * 4), y3);
			y0, y1, y2, y3 = buffer.readu32(x, (15 * 4)),buffer.readu32(x, (12 * 4)),buffer.readu32(x, (13 * 4)),buffer.readu32(x, (14 * 4)) :: number;
			do
				y1 = bit32.bxor(y1, bit32.lrotate(y0 + y3, 7)) :: number;
				y2 = bit32.bxor(y2, bit32.lrotate(y1 + y0, 9)) :: number;
				y3 = bit32.bxor(y3, bit32.lrotate(y2 + y1, 13)) :: number;
				y0 = bit32.bxor(y0, bit32.lrotate(y3 + y2, 18)) :: number;
			end;
			buffer.writeu32(x, (15 * 4), y0);
			buffer.writeu32(x, (12 * 4), y1);
			buffer.writeu32(x, (13 * 4), y2);
			buffer.writeu32(x, (14 * 4), y3);
		end;
		for i: number = 1, 30 do
			i -= 1;
			buffer.writeu32(z,(i * 4),buffer.readu32(z, (i * 4))+buffer.readu32(x, (i * 4)));
		end;
		for i: number = 1, 20 do
			i -= 1;
			do
				local operand: number = (i * 4);
				local w: number = buffer.readu32(z, (operand));
				buffer.writeu8(hash_1, operand, bit32.rshift(w, 8));
				buffer.writeu8(hash_1, (operand + 1), bit32.rshift(w, 16));
				buffer.writeu8(hash_1, (operand + 2), bit32.rshift(w, 24));
			end;
		end;
		buffer.writeu32(hash_2, (8 * 4), (buffer.readu32(hash_2, (8 * 4)) + 1));
		for i: number = 1, rounds do
			i -= 1;
			if ((offset + i) >= msg_len) then
				break;
			end;
			buffer.writeu8(result, (offset+i), bit32.bxor(buffer.readu8(msg, (offset + i)), buffer.readu8(hash_1, i)))
		end;
		offset += 1;
	end;
	buffer.fill(hash_1, 0, 0);
	buffer.fill(hash_2, 0, 0);
	hash_1 = nil :: never;
	hash_2 = nil :: never;
	key = nil :: never;
	msg = nil :: never;
	return result;
end;
return crypt;
