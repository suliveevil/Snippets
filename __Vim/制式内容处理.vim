from

apple
bird
cat
dog

to

apple=listdata['name']['apple']
bird=listdata['name']['bird']
cat=listdata['name']['cat']
dog=listdata['name']['dog']

" solution 1
作者：zecy 链接：https://www.zhihu.com/question/30875543/answer/49843873

:%s/.*/&=listdata['name']['&']

:v/+/exe "s/".getline(".")."/&=listdata['name']['&']"


:py for i in range(len(vim.current.buffer)):vim.current.buffer[i]=vim.current.buffer[i]+"=listdata['name']['"+vim.current.buffer[i]+"']"

" vim.current.buffer = '\n'.join(x+"=listdata['name']['"+x+"']" for x in vim.current.buffer)

" solution 2

s = '''
apple
bird
cat
dog
'''

print('n'.join(x+"=listdata['name']['"+x+"']" for x in s.split('\n') if x)
