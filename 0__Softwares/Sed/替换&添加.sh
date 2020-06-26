# 替换/data下所有文件中的testString为newString
sed -i "s/testString/newString/g" `grep testString -rl /data`

# 删除test.txt中含"test"的行，
# 但不改变test.txt文件本身，操作之后的结果在终端显示
sed -e '/test/d' test.txt

# 删除test.txt中含"test"的行，
# 将操作之后的结果保存到test_new.txt
sed -e '/test/d' test.txt > test_new.txt

# 删除含字符串"test"或"boy"的行，
# 将结果保存到test_new.txt
sed '/test/d;/boy/d' test.txt > test_new.txt