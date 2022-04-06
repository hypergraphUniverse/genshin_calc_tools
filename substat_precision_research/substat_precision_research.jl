#This is a script that generates the full reverse table, which projects the Artifact substats back to the exact precision.

using Printf
using CSV
using DataFrames

Data=
[209.13f0 239.0f0 268.88f0 298.75f0;     #hp
0.0408f0 0.0466f0 0.0525f0 0.0583f0;     #hp_percent
13.62f0 15.56f0 17.51f0 19.45f0;         #attack
0.0408f0 0.0466f0 0.0525f0 0.0583f0;     #attack_percent
16.20f0 18.52f0 20.83f0 23.14f0;         #defence
0.0510f0 0.0583f0 0.0656f0 0.0729f0;     #defence_percent
0.0453f0 0.0518f0 0.0583f0 0.0648f0;     #charge_efficiency
16.32f0 18.65f0 20.98f0 23.31f0;         #element_mastery
0.0272f0 0.0311f0 0.0350f0 0.0389f0;     #critical
0.0544f0 0.0622f0 0.0699f0 0.0777f0]     #critical_hurt

MAX_num = [1076f0,0.210f0,82f0,0.210f0,97f0,0.313f0,0.285f0,68f0,0.179f0,0.458f0]
# 来自网站 https://www.kdocs.cn/l/crZVcn9YA26J


title=["hp", "hp_percent", "attack", "attack_percent", "defence", "defence_percent", 
"charge_efficiency", "element_mastery", "critical", "critical_hurt"]

#对元组进行迭代，如果超过最大值，endflag处为1
function next((end_flag,r1,r2,r3,r4))
    sum=r4+r3+r2+r1
    if sum<6
        r1=r1+1
    elseif sum==6
        if r1!=0
            r1=0
            r2=r2+1
        elseif r2!=0
            r2=0
            r3=r3+1
        elseif r3!=0
            r3=0
            r4=r4+1
        elseif r4!=0
            end_flag=1
        else 
            error("Should not be here!P1")
        end
    else
        error("Should not be here!P2")
    end
    return (end_flag,r1,r2,r3,r4)
end

# 两个收集信息的列表
list_full=Vector{Vector{Any}}(undef,0) # 全部列表
list_tie=Vector{Vector{Any}}(undef,0) # 边界列表

#对于每一个类型而言
for x in 1:10
    current=(0,1,0,0,0)
    list=Vector{Vector{Any}}(undef,0)

    #Data Processing
    while current[1]==0
        sum_of=current[2]*Data[x,1]+current[3]*Data[x,2]+current[4]*Data[x,3]+current[5]*Data[x,4] # 原始数据
        
        digitAlign=0f0  # 对齐两位消除尾数数据
        if x== 1 || x==3 || x==5 || x==8
            digitAlign=round(sum_of;digits=2)
        else
            digitAlign=round(sum_of;digits=5)
        end
        
        if x== 1 || x==3 || x==5 || x==8  # 四舍五入后数据
            rounded=round(sum_of,RoundNearestTiesUp)  
        else
            rounded=round(sum_of,RoundNearestTiesUp;digits=3)
        end
        
        push!(list,[sum_of,current,digitAlign])
        push!(list_full,[title[x],current,digitAlign,rounded,sum_of,x])
        current=next(current)
    end

    #sort
    sort!(list,by=x->x[1])
    sort!(list_full,by=x->(x[6],x[5]))

    #output
    print("\n\nTable for ",title[x],"\n");
    for i in 1:size(list)[1]

        # "Combination"
        print(list[i][2]," ");
        
        # "Rounded Output/四舍五入"
        if x== 1 || x==3 || x==5 || x==8
            print("RO:",round(list[i][1],RoundNearestTiesUp)," \t")
        else
            print("RO:",round(list[i][1],RoundNearestTiesUp;digits=3)," \t")
        end

        # "Data in more precision/消除尾数的完整数据"
        if x== 1 || x==3 || x==5 || x==8
            @printf("MP:%.2f ",list[i][1])
        else
            @printf("MP:%.5f ",list[i][1])
        end

        # "Data in full precision/加减法之后原始数据"
        print("FP:",list[i][1]," ");
        
        # search for the ties
        strlength=length(string(list[i][3]))                   # 字符串实际长度
        pointpos=collect(findfirst(".",string(list[i][3])))[1] # 小数点位置
        if x== 1 || x==3 || x==5 || x==8                       # 判断是否为边界条件
            if strlength-pointpos == 1  && string(list[i][3])[pointpos+1] == '5'
            #  小数点后只有一位          且   取整之后转换成字符串 小数点后第一位 如果是5
                print("\t      TIE");
                push!(list_tie,push!(list[i],title[x],x,round(list[i][3],RoundNearestTiesUp)))
            end
        else
            if strlength == 6  &&  string(list[i][3])[pointpos+4] == '5'
            #  字符串长度为6    且   取整之后转换成字符串 小数点后第四位 如果是5
                print("\t      TIE");
                push!(list_tie,push!(list[i],title[x],x,round(list[i][3],RoundNearestTiesUp;digits=3)))
            end
        end

        print("\n");
    end
end

print("\n\nTable for Ties\n");
for i in 1:size(list_tie)[1]
 
    # "Combination"
    print(list_tie[i][2]," ");

    # "Rounded Output/四舍五入"
    print("RO:",list_tie[i][6]," \t")
    
    
    # "Data in more precision"
    if list_tie[i][5] == 1 || list_tie[i][5] ==3 || list_tie[i][5] ==5 || list_tie[i][5] ==8
        @printf("MP:%.2f ",list_tie[i][1])
    else
        @printf("MP:%.5f ",list_tie[i][1])
    end

    # "Data in full precision"
    print("FP:",list_tie[i][1]," ");
    
    print(list_tie[i][4]);

    print("\n");
end

#用于在列表中检索相同取整值但是背后实际小数不同的函数，用于表达
function search_same_ru(type_x,Round,Data=0)
    global list_full
    if type_x== 1 || type_x==3 || type_x==5 || type_x==8
        Round=round(Round)
    else
        Round=round(Round;digits=3)
    end
    result="Y"
    for i in 1:length(list_full)
        if list_full[i][6]==type_x && list_full[i][4] == Round && list_full[i][3]!=Data
        # 标签名相同                  rounded值等于输入的Round值     digitAlign不等于Data
            result="N:"*string(list_full[i][3])*" "*string(list_full[i][2]);
            break;
        end
    end
    return result
end

# Output in CSV 
# Full list
out_full = mapreduce(permutedims, vcat, list_full)
nms_full = ["Name","Tuples","Data","Data-Original","RoundNearestTiesUp"]
out_full = out_full[:,[1,2,3,5,4]]
DF_full = DataFrame(out_full,nms_full)
CSV.write("output_full.csv",DF_full)

# Tie list
out_tie = mapreduce(permutedims, vcat, list_tie)
nms_tie = ["Name","Tuples","Data","Data-Original"] 
out_tie = out_tie[:,[4,2,3,1]]
DF_tie = DataFrame(out_tie,nms_tie)
CSV.write("output_tie.csv",DF_tie)

# Tie Analyzed list
out_tie_analyze = mapreduce(permutedims, vcat, list_tie)
nms_tie_analyze = ["Name","Tuples","Data","Data-Original","display","difference","unique value","unique falsify"] 
display = Vector{Any}(undef,0);
diff = Vector{Any}(undef,0);
uni_val = Vector{Any}(undef,0);
uni_false = Vector{Any}(undef,0);  

for i in 1:length(list_tie)
    # display
    #=
    if out_tie_analyze[i,3] <= MAX_num[out_tie_analyze[i,5]]
        push!(display," ")
    else
        push!(display,"OOR("*string(out_tie_analyze[i,6])*")");
    end
    =#
    push!(display,string(out_tie_analyze[i,6]));

    #diff
    if out_tie_analyze[i,5]== 1 || out_tie_analyze[i,5]==3 || out_tie_analyze[i,5]==5 || out_tie_analyze[i,5]==8
        ru=round(out_tie_analyze[i,3],RoundNearestTiesUp)
        rn=round(out_tie_analyze[i,3],RoundNearest)
    else
        ru=round(out_tie_analyze[i,3],RoundNearestTiesUp;digits=3)
        rn=round(out_tie_analyze[i,3],RoundNearest;digits=3)
    end
    
    if ru != rn
        if out_tie_analyze[i,1]!=out_tie_analyze[i,3]
            push!(diff,"Y*");
        else
            push!(diff,"Y");
        end
    else
        push!(diff,"N");
    end

    #uni_val
    push!(uni_val,search_same_ru(out_tie_analyze[i,5],out_tie_analyze[i,6],out_tie_analyze[i,3]))

    #uni_false
    if out_tie_analyze[i,5]== 1 || out_tie_analyze[i,5]==3 || out_tie_analyze[i,5]==5 || out_tie_analyze[i,5]==8
        ru_low=ru-1f0
    else
        ru_low=ru-0.001f0
    end
    push!(uni_false,search_same_ru(out_tie_analyze[i,5],ru_low))
end

out_tie_analyze = [out_tie_analyze[:,[4,2,3,1]] display diff uni_val uni_false]
DF_tie_analyze = DataFrame(out_tie_analyze,nms_tie_analyze)
CSV.write("output_tie_analyze.csv",DF_tie_analyze)

#generate three lists

pos_list = Matrix{Any}(undef,0,8);
neg_list = Matrix{Any}(undef,0,8);
err_list = Matrix{Any}(undef,0,8); 

for i in 1:size(out_tie_analyze)[1]
    if out_tie_analyze[i,6][1] == 'Y'
        if out_tie_analyze[i,7][1] == 'Y'
            global pos_list = [pos_list;permutedims(out_tie_analyze[i,:])]
        end
        if out_tie_analyze[i,8][1] == 'Y'
            global neg_list = [neg_list;permutedims(out_tie_analyze[i,:])]
        end
    elseif out_tie_analyze[i,6][1] == 'N'
        if out_tie_analyze[i,8][1] == 'Y'
            global err_list = [err_list;permutedims(out_tie_analyze[i,:])]
        end
    else
        error("Should not be here!")
    end
end

CSV.write("list_positive.csv",DataFrame(pos_list,nms_tie_analyze))
CSV.write("list_negative.csv",DataFrame(neg_list,nms_tie_analyze))
CSV.write("list_error.csv",DataFrame(err_list,nms_tie_analyze))