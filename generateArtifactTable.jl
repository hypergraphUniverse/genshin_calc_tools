#This is a script that generates the full reverse table, which projects the Artifact substats back to the exact precision.

using Printf

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

title=["hp", "hp_percent", "attack", "attack_percent", "defence", "defence_percent", 
"charge_efficiency", "element_mastery", "critical", "critical_hurt"]


function nextgen(v1::Vector{Float32},v2::Vector{Float32})
    res=zeros(Float32,0);

    for i in 1:length(v1)
        for j in 1:length(v2)
            push!(res,v1[i]+v2[j]);
        end
    end

    res=sort(unique(res));
    return res;
end



for x in 1:10

    global title;

    #initialize and make iterations
    v=repeat([[0f0]],6);
    v[1]=Data[x,:]
    for i in 2:6
        v[i]=nextgen(v[i-1],v[1])
    end
    
    # append the iter-counter
    w=repeat([[0f0 0f0;0f0 0f0]],6)
    for i in 1:6
        w[i]=hcat(v[i],repeat([i],length(v[i])))
    end
    
    # collect and sort incremental
    res=vcat(w[1],w[2],w[3],w[4],w[5],w[6])
    res=res[sortperm(res[:,1]),:]

    # output the result
    print("\n\nTable for ",title[x],"\n");
    if x== 1 || x==3 || x==5 || x==8
        for i in 1:size(res)[1]
            @printf("%.0f    %.2f    %.0f\n",res[i,1],res[i,1],res[i,2])
        end
    else
        for i in 1:size(res)[1]
            @printf("%.3f    %.5f    %.0f\n",res[i,1],res[i,1],res[i,2])
        end
    end
end

    
