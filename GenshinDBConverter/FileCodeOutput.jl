# This is the Module for Code output in different style
# Specified for Genshin Impact, Types are Float32

module FileCodeOutput

export Print2DMatrix,Print3DMatrix

# syntax dictionary
dictLanguage=Dict(
    "C"=>Dict(
    "termsuffix"=> "f",
    "termSplitter" => ", ",
    "lineStart" => "{",
    "lineEnd" => "},",
    "matrixStart" => "{",
    "matrixEnd" => "}",
    "comment" => "//",
    "terminator" => ";",
    ),
    "Julia"=>Dict(
    "termsuffix" => "f0",
    "termSplitter" => " ",
    "lineStart" => "",
    "lineEnd" => ";",
    "matrixStart" => "[",
    "matrixEnd" => "]",
    "comment" => "#",
    "terminator" => ";",
    ),
);

# Function to print 2D Data
function Print2DMatrix(f,M;tabLen=0,varName="",codeStyle="C")
    global dictLanguage

    # print variableName if needed
    if varName!=""
        print(f,varName);
        if codeStyle=="C"
            for i in 1:length(size(M))
                print(f,"["*string(size(M)[i])*"]");
            end
        end
        print(f,"=\n");
    end

    # print the mainpart of 2D Matrix
    print(f, repeat(" ",tabLen*4) * dictLanguage[codeStyle]["matrixStart"] * "\n");
    for i in 1:size(M)[1]
        print(f, repeat(" ", (tabLen+1)*4) * dictLanguage[codeStyle]["lineStart"]);
        for j in 1:size(M)[2]
            print(f, string(M[i,j]) * dictLanguage[codeStyle]["termsuffix"] * dictLanguage[codeStyle]["termSplitter"]);
        end
        print(f, dictLanguage[codeStyle]["lineEnd"] * "\n");
    end
    print(f, repeat(" ",tabLen*4) * dictLanguage[codeStyle]["matrixEnd"]);

    # print Terminator
    (varName!="")&&print(f, dictLanguage[codeStyle]["terminator"]);
    (varName=="")&&print(f, dictLanguage[codeStyle]["termSplitter"]);
    print(f,"\n");

end

# Function to print 3D Data
function Print3DMatrix(f,M;tabLen=0,varName="",codeStyle="C")
    global dictlanguage

    # print variableName if needed
    if varName!=""
        print(f,varName);
        if codeStyle=="C"
            for i in 1:length(size(M))
                print(f,"["*string(size(M)[i])*"]");
            end
        end
        print(f,"=");
    end

    # print the main part in different codeStyle
    if codeStyle=="C"
        print(f,"\n");
        print(f,repeat(" ",tabLen*4) * "{\n");
            for i in 1:size(M)[1]
                Print2DMatrix(f,M[i,:,:];tabLen=tabLen+1,codeStyle="C")
            end
        print(f,"}");
    elseif codeStyle=="Julia"
        print("Array{Float32,3}(undef,"*string(size(M)[1])*","*string(size(M)[2])*","*string(size(M)[3])*")\n");
        for i in 1:size(M)[1]
            Print2DMatrix(f,M[i,:,:];varName=varName*"["*string(i)*",:,:]",codeStyle="Julia");
        end
    else
        error("Keyword codeStyle unsupported!")
    end

    # print Terminator
    (varName!="")&&print(f, dictLanguage[codeStyle]["terminator"]);
    print(f,"\n");
end

# Function to print a Sturcture/Dictionary or such
# function PrintDict()
# end

end

