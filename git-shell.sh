#!/bin/sh

readonly now="$(date +'%Y%m%d%H%M%S')"
readonly devBranch="build_bak"
readonly releaseBranch="tuyi_publish_branch"
readonly masterBranch="master"

deploy() {
    hexo d -g
}

release() {
    git add .
    git commit -m "Update ${now}"
    git push
}

echo 'a、部署文章'
echo 'b、推送变更'
echo 'c、部署并推送'
echo '请根据字母选择您的操作：'

read isOk

case $isOk in
    a)
        deploy
        break
        ;;
    b)
        release
        break
        ;;
    c)
        deploy
        release
        break
        ;;
    *)
        echo '无效的选择'
        break
        ;;
esac
