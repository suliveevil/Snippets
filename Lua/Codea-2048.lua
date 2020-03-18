
--# Main
--刚接触Lua和游戏开发，写得不好多多谅解，也欢迎指教！

width=530
height=720 --游戏窗口大小
startx=15
starty=150 --棋盘格的左下角坐标
sum=width-2*startx --棋盘格的总边长
num=4 --num*num的棋盘格
each=sum/num  --每个小格子的边长
score=0  
data = {}

-- setup函数会最先运行，只运行一次，用于初始化
function setup()
    for i=1,num do
        data[i] = {}
        for j=1,num do
            data[i][j] = 0
        end
    end
    put_num()
end

-- draw每秒运行60次，是绘图函数
function draw()
    --游戏窗口和棋盘窗口
    background(0, 0, 0, 255)    
    fill(250, 248, 239, 255)
    translate(WIDTH/2-100,HEIGHT/2-350)
    rectMode(CORNER)
    rect(0,0,width,height)
    fill(222, 202, 188, 255)
    rect(startx,starty,sum,sum) 
    
    --标题 分数 提示语
    font("Futura-CondensedExtraBold")
    fontSize(50)
    text("2048", startx+60, starty+sum+30)
    fontSize(40)
    text(string.format("score: %d",score),startx+350,starty+sum+30)
    fontSize(20)
    text("Slide the screen to play the game!",startx+250,starty-50)
    draw_line()
    draw_num()
    
    --以下用于判断游戏结束（当往上下左右滑动都无法改变data后，游戏结束）
    --本代码没有加入通关的判断条件，可以自行研究
    _,eq1,_=slideUpDown(true)
    _,eq2,_=slideUpDown(false)
    _,eq3,_=slideRightLeft(true)
    _,eq4,_=slideRightLeft(false)
    if eq1 and eq2 and eq3 and eq4 then
        font("Verdana-Bold")
        fill(95, 255, 0, 255)
        rect(50,300,420,210)
        fill(255, 0, 0, 255)
        stroke(0, 0, 0, 255)
        fontSize(50)
        textWrapWidth(400)
        text("你打破了世界最低记录，求你别玩了！",startx+250,starty+250) --以上为结束显示的内容，可自行修改
        --sound(SOUND_EXPLODE, 11631)  --注意：由于该语句位于draw函数内，声音会被反复开启，成为刺耳的故障音
    end
end

--touched是检测到触摸后会启动的函数
function touched(touch)
    if  touch.state==ENDED and touch.delta:len()>4 then  --关于触摸建议去侧栏好好看看资料，此处的意思是
                                                        --如果触摸状态为ENDED并且滑动距离的长度大于4
        Delta = touch.delta
        move_judge(Delta) --Delta是二维向量
        sound(SOUND_JUMP, 39587) --滑动声音
    end
end

--draw_line是画棋盘格的线的函数
function draw_line()
    stroke(255, 255, 255, 255)
    strokeWidth(1)
    noSmooth()
    --水平线
    for i = 0,num do
        lineCapMode(SQUARE)
        line(startx,starty+i*each,startx+sum,starty+i*each)
    end
    --垂直线
    for i = 0,num do
        lineCapMode(SQUARE)
        line(startx+each*i,starty,startx+each*i,starty+sum)
    end
end

--draw_num是把data画在棋盘格上的函数
function draw_num()
    font("Verdana-Bold")
    fontSize(50)
    for row=1,num do
        for col =1,num do
            x=startx+each*col-each/2
            y=starty+sum-each*row+each/2
            if data[row][col] and data[row][col]>0 then
                --各不同数字设置不同的底色
                if data[row][col]==2 then
                    fill(238, 228, 218, 255)
                    rect(startx+each*(col-1),starty+sum-each*row,each,each)
                elseif data[row][col]==4 then
                    fill(237,224,200,255)
                    rect(startx+each*(col-1),starty+sum-each*row,each,each)
                elseif data[row][col]==8 then
                    fill(235, 237, 200, 255)
                    rect(startx+each*(col-1),starty+sum-each*row,each,each)
                elseif data[row][col]==16 then
                    fill(220, 170, 172, 255)
                    rect(startx+each*(col-1),starty+sum-each*row,each,each)
                elseif data[row][col]==32 then
                    fill(125, 193, 216, 255)
                    rect(startx+each*(col-1),starty+sum-each*row,each,each)
                elseif data[row][col]==64 then
                    fill(205, 214, 136, 255)
                    rect(startx+each*(col-1),starty+sum-each*row,each,each)
                elseif data[row][col]==128 then
                    fill(200, 237, 223, 255)
                    rect(startx+each*(col-1),starty+sum-each*row,each,each)
                elseif data[row][col]==256 then
                    fill(173, 214, 77, 255)
                    rect(startx+each*(col-1),starty+sum-each*row,each,each)
                elseif data[row][col]==512 then
                    fill(214, 92, 79, 255)
                    rect(startx+each*(col-1),starty+sum-each*row,each,each)
                elseif data[row][col]==1024 then
                    fill(220, 108, 173, 255)
                    rect(startx+each*(col-1),starty+sum-each*row,each,each)
                elseif data[row][col]==2048 then
                    fill(238, 32, 5, 255)
                    rect(startx+each*(col-1),starty+sum-each*row,each,each)
                end
                fill(16, 16, 16, 255)
                text(string.format("%d",data[row][col]), x, y)
            end
        end
    end
end

--move_judge是通过delta这个二维向量来判断上下左右的函数，求出delta与（0，1）（1，0）（0，-1）（-1，0）的夹角
--通过这个角的大小判断方向（不清楚这里面有没有直接的接口判断上下左右，暂时没找到....）
function move_judge(delta)
    local eq = true
    local touch = false
    local score_plus = 0
    local angle = math.deg(delta:angleBetween(vec2(1,0)))
    if angle<30 and angle>-30 then --注意：左和上是true、右和下是false
        data,eq,score_plus=slideRightLeft(false)
        print("right")
    elseif angle<120 and angle>60 then
        data,eq,score_plus=slideUpDown(false)
        print("down")
    elseif angle<-150 or angle>150 then
        data,eq,score_plus=slideRightLeft(true)
        print("left")
    elseif angle<-60 and angle>-120 then
        data,eq,score_plus=slideUpDown(true)
        print("up")
    end
    score=score+score_plus
    if not eq then  --只有滑动后且数据改变了才添加一个新数据
        put_num()
    end
end

--slideRightLeft规定左移和右移后data要如何改变
function slideRightLeft(left)
    local CloneData=clone(data) --先把data拷贝
    local sco=0 --sco是新产生的分数
    for row =1,num do --for循环，每次只对一行数据操作（行向量）
        --第一步：提取非零数据到rvl
        local rvl={}
        local j=1
        for col=1,num do
            if CloneData[row][col] and CloneData[row][col]> 0 then
                rvl[j]=CloneData[row][col]
                j=j+1
            end
        end
        --第二步：调用merge函数，进行合并，具体规则参见merge的注释
        if #rvl>=2 then
            sco=sco+merge(rvl,left)
        end
        
        --第三步：将行向量用零填满，需要填的个数是num-#rvl
        len=#rvl
        for i =1,num-len do
            if left then  --注意：左移是在rvl末尾填零，右移是在rvl首位上填零
                table.insert(rvl,0) 
            else
                table.insert(rvl,1,0)
            end
        end
        --第四步：将rvl的数据赋给CloneData
        for col=1,num do
            CloneData[row][col] = rvl[col]
        end
    end 
    return CloneData, equal(CloneData,data),sco
     --equal是判断数据有没有真正改变，此处不能用“==”判断
end

--slideUpDown是规定上移和下移后data要如何改变，算法和左右移动一致，只是变成了列向量
function slideUpDown(up)
    local CloneData=clone(data)
    local sco=0
    local rvl
    for col =1,num do
        rvl={}
        local j=1
        for row=1,num do
            if CloneData[row][col] and CloneData[row][col] >0 then
                rvl[j]=CloneData[row][col]
                j=j+1
            end
        end
        if #rvl>=2 then
            sco=sco+merge(rvl,up)
        end
     for i =1,num-#rvl do
            if up then
                table.insert(rvl,0)
            else
                table.insert(rvl,1,0)
            end
        end
        for row=1,num do
            CloneData[row][col] = rvl[row]
        end
    end 
    return CloneData, equal(CloneData,data),sco
end

--merge是合并相邻且相等数字的函数
function merge(list,direct)
    sco_=0
    if direct then --如果是左或者上
        i=1
        while(i<#list)
        do
            if list[i]==list[i+1] then --从首位开始判断是否相等，若相等：remove其中一个，另一个乘以2
                table.remove(list,i+1)
                list[i]=2*list[i]
                sco_ = sco_+list[i]
            end
            i=i+1
        end
    else --如果是右或者下
        i=#list
        while(i>1)
        do
            if list[i-1]==list[i] then --从末尾开始判断是否相等，若相等：remove其中一个，另一个乘以2
                table.remove(list,i)
                list[i-1]=2*list[i-1]
                sco_ = sco_+list[i-1]
            end
            i=i-1
        end
    end
    return sco_
end

--put_num会在随机的一个空格里添加一个2或4
function put_num()
    local available ={}
    for row=1,num do
        for col=1,num do
            if data[row][col] ==0 then 
                table.insert(available,{row,col})
            end
        end
    end
    if #available~=0 then
        putxy=available[math.random(1,#available)]
        row,col=putxy[1],putxy[2]
        if math.random(0,1)==1 then
            data[row][col] = 2
        else
            data[row][col] = 4
        end
    end
end

--这是一个深拷贝函数，如不清楚深拷贝的概念，请自行百度“深拷贝与浅拷贝”
function clone(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for key, value in pairs(object) do
            new_table[_copy(key)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

--判断两个table是否完全相等
function equal(a, b)
    if #a ~= #b then
        return false
    end
    for i = 1, #a do
        for j =1,#a do
            if a[i][j] ~= b[i][j] then
                return false
            end
        end
    end
    return true
end







