#!/bin/sh

set -e

PODSPEC_FILE=
PODSPEC_JSON_FILE=
# 检查命令是否存在
function check_commond() {
	command -v $1 >/dev/null 2>&1 || { echo >&2 "I require \033[31m\033[01m\033[05m[ $1 ]\033[0m but it's not installed.  Aborting."; exit 1; }
}

# 提取 podspec 文件名称
function extract_podspec_file() {
	PODSPEC_FILE=$(ls $PWD | grep 'podspec$')
}

# 将 podspec 转为json 格式
function conver_json() {
	PODSPEC_JSON_FILE=$PODSPEC_FILE.json
	pod ipc spec $1 > $PODSPEC_JSON_FILE
	if [ ! -f $PODSPEC_JSON_FILE ]; then
		echo "podspec conver to json failure"
		exit 1
	fi
}

# 从 podspec.json 文件中提取信息
function extract_target() {
	target=$(cat $1 | jq $2)
	target=${target//\"/""}
	echo $target
}

# 打 tag
function add_tag() {
	exist=$(echo $(git tag -l | grep $1))
	if [[ "$exist" == "$1" ]]; then
		echo "tag: $1 已经存在"
		git tag -d ${1}
		git push origin :${1}
	else
		echo "tag: $1 不存在"
	fi
	git tag -m '版本:${1} 提交' ${1}
	git push --tag
}

# 验证提交
function validation_submit() {
	pod cache clean $1 --all
	pod trunk push $2 \
	--allow-warnings \
	--verbose
	pod cache clean ${1} --all
}

check_commond pod
check_commond git
check_commond jq

extract_podspec_file
conver_json $PODSPEC_FILE

FrameworkName=$(extract_target $PODSPEC_JSON_FILE '.name')
Version=$(extract_target $PODSPEC_JSON_FILE '.version')

if [[ -f $PODSPEC_JSON_FILE ]]; then
	rm -rf $PODSPEC_JSON_FILE
fi

add_tag $Version
if [[ $1 != "-g" ]]; then
	echo "validation_submit"
	validation_submit $FrameworkName $PODSPEC_FILE
fi