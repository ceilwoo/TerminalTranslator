# TerminalTranslator
Terminal Translator v1.0
命令行中英翻译脚本

# 更新历史
v1.1 新增mac系统下的发音，使用参数-v

KEY申请:  http://fanyi.youdao.com/openapi
替换脚本的key和keyfrom值

<h4>使用：</h4>
ruby translate.rb 要查询的单词

<h4>建议使用方式：</h4>
在.bash_profile增加一行 alias tl="ruby /存放路径/translate.rb" </br>
然后命令行里啪啪啪的敲个 tl XXX 就可以查单词了

<h4>更新日志：</h4>
<p>v1.1 20151106	  add voice for mac os, add '-v' to set actived, Example: ruby translate.rb ceil -v
                <br/ >support short sentence</p>
<p>v1.0 20150905   init</p>
