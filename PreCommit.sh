echo "-----统计新增文件大小 BEGIN---"

count=0
git status --short | awk '$1 == "A" { print $2 }' | while read file 
do
  	# workdir=$(cd $(dirname $0); pwd)
  	# echo $workdir

  	current_path="$PWD"
  	echo $current_path
	fname=$current_path/$file

	filesize=`ls -l $fname | awk '{ print $5 }'`
	kb=1024
	size=`expr $filesize / $kb`
	if [[ $size -gt 10 ]]; then
		count+=1
	fi

	awk 'BEGIN{printf "%.2fkb '$file'\n",('$filesize'/'$kb')}'
done 

echo "-----统计新增文件大小 END ---"
echo "此次提交大于10kb的文件数量："$count
echo "-----------------------"