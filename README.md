# genshin_calc_tools
Tools for Genshin calculation, mostly small script for a specific target. \
一些原神运算的小工具，大多数是一些完成特定任务的小脚本


## Lists of tools

- (Paused)GenshinDataConverter \
A tool that Converts JSON file in Dimbreath\\GenshinData into a specific codestyle that can be directly used in your programming Project. Already transferred in this repo https://github.com/hypergraphUniverse/GenshinDataConverter. Project now stopped.
一个可以将Dimbreath\\GenshinData中的JSON数据转换成对应数据类型的脚本，输出结果可以直接使用在各类编程软件中。 已经转移到了上述链接指向的仓库中。项目目前停止。

- **floatTypeValidation** \
The Experiment about the Precision in Genshin(Float32 or Float64). \
实验验证原神数据精度(Float32还是Float64)。

- generateArtifactTable -> use substat_precision_research instead\
(Outdated,with mistake)Generate the Artifact substat reverse cheatsheet for exact value, the result is also uploaded. \
(过时的,有错误的)生成原神副词条实际小数值的查询表，结果一并由txt上传。

- **Hutao_calc** \
A high-precision calculation example on my own Hutao. Please refers to https://bbs.mihoyo.com/ys/article/18314962 for details. \
一个高精度计算的案例，用的是我的胡桃，请前往米游社上述链接查看对比。

- **substat_precision_research** \
A all-round analysis about the precison of substat display. Also includes output. \
一个非常详尽的分析圣遗物副词条的工具，同时附上了输出。
  - substat_precision_research.jl \
  Main Program. It is alreadly nearly unreadable because I didn't have a clear planning about what it should do, so the code grows like shit mountain. Still works. \
  主程序。因为没有对功能进行规划，所以在不断扩展功能最终变成了一个屎山。仍然可用（有没有bug，修不修得起就不敢保证了）
  - csv files \
  Output of the Main Program \
  主程序的输出
    > - output_full: \
    > Full data about substat. Works better than generateArtifactTable above.\
    > 圣遗物副词条的全部数据，比上面generateArtifactTable要好用
    > - output_tie/output_tie_analyze:\
    > An analysis about how programm behaves when making rounding with ties.\
    > 一个关于程序在取整距离相等时如何表现的分析。
    > - list_positive/negative/error:\
    > Please refers to the links above to know what it exactly means.\
    > 请参照上面的链接来得知这些表格的详细含义。
  - xlsx files \
  Result after my own edit with existing data in [The existing 5-star substat](https://www.kdocs.cn/l/crZVcn9YA26J). Also please refers to link above to details.\
  我手工处理后的数据，处理来源是 [5星圣遗物副词条数值收集](https://www.kdocs.cn/l/crZVcn9YA26J)。请参照我的帖子了解具体含义。
  
