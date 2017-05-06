#!bin/bash
echo === printfile information===
echo current directory : `pwd`
where=`pwd`
num=`ls --group-directories-first | wc -l`
echo the number of elements : $num
for((i=1; i<=num; i++))
do
        filename=`ls --group-directories-first | head -n $i | tail -n -1`
        filetype=`stat $filename | grep Size: | cut -f 4 -d ':' | cut -f 4,5,6 -d ' '`
        filetype_FI=`stat $filename | grep Size: | cut -f 4 -d ':' | cut -f 4,5 -d ' '`
        filetype_pe=`stat $filename | grep Size: | cut -f 4 -d ':' | cut -f 4,5,6,7 -d ' '`

                echo ┌ [ $i ]$filename
                echo │-------------------------INFORMATION-------------------------
                if [ "$filetype" = " 일반 파일" ];
                        then
                                echo │file type :$filetype
                elif [ "$filetype_pe" = " 일반 빈 파일" ];
                        then
                                echo │file type :$filetype_pe
                elif [ "$filetype" = " 디렉토리" ];
                        then
                                echo │[34mfile type :$filetype
                elif [ "$filetype_FI" = " FIFO" ];
                        then
                                echo │[32mfile type :$filetype_FI
                fi
                echo [0m│file size :`stat $filename | grep Size: | cut -f 2 -d ':' | cut -f 1 -d 'B'`
                echo │last modify time :`stat $filename | grep Change | cut -f 2,3,4,5 -d ':'`
                echo │permission : `stat $filename | grep Uid: | cut -f 2 -d ':' | cut -f 2 -d '(' | cut -f 1 -d '/'`
                echo │absolute path : `ls -d $PWD/$filename`
                echo │relative path : `cd $where | find -name $filename`
                echo └-------------------------------------------------------------

        if [ "$filetype" = " 디렉토리" ]
                then
                numm=`ls --group-directories-first $filename | wc -l`
                for((j=1; j<=numm;j++))
                do
                filename_D=`ls --group-directories-first $filename | head -n $j | tail -n -1`
                filetype_D=`stat $filename/$filename_D | grep Size: | cut -f 4 -d ':' | cut -f 4,5,6 -d ' '`
                filetype_pe_D=`stat $filename/$filename_D | grep Size: | cut -f 4 -d ':' | cut -f 4,5,6,7 -d ' '`
                filetype_FI_D=`stat $filename/$filename_D | grep Size: | cut -f 4 -d ':' | cut -f 4,5 -d ' '`
                                echo "          "┌ [ $j ]$filename/$filename_D
                                echo "          "│-------------------------INFORMATION-------------------------
                        if [ "$filetype_D" = " 일반 파일" ];
                                then
                                        echo "          "│file type :$filetype_D
                        elif [ "$filetype_pe_D" = " 일반 빈 파일" ];
                                then
                                        echo "          "│file type :$filetype_pe_D
                        elif [ "$filetype_D" = " 디렉토리" ];
                                then
                                        echo "          "│[34mfile type :$filetype_D
                        elif [ "$filetype_D" = " FIFO" ];
                                then
                                        echo "          "│[32mfile type :$filetype_FI_D
                        fi
                echo [0m"          "│file size :`stat $filename/$filename_D | grep Size: | cut -f 2 -d ':' | cut -f 1 -d 'B'`
                echo "          "│last modify time :`stat $filename/$filename_D | grep Change | cut -f 2,3,4,5 -d ':'`
                echo "          "│permission : `stat $filename/$filename_D | grep Uid: | cut -f 2 -d ':' | cut -f 2 -d '(' | cut -f 1 -d '/'`
                echo "          "│absolute path :`ls -d $PWD/$filename/$filename_D`
                echo "          "│relative path : `cd $PWD/$filename | find -name $filename_D | grep $filename`
                echo "          "└-------------------------------------------------------------
                done
     fi
done

