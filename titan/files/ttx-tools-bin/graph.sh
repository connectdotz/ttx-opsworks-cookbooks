#!/bin/bash

DIR=$(cd $(dirname "$0"); pwd)
mailTo = ops@thingtrix.com

function usage()
{
	echo "[Usage] graph.sh -a [(action) backup/restore] -v [(version) prod/test/alpha] graphName"
	exit -1
}


function backup ()
{
	version=$1
	graph=$2


    input=/tmp/backup.gremlin
    output=/tmp/backup.output

	#generate backup script
	backupDir=/var/opt/thingtrix/graphdb/backup
	now=$(date +"%Y_%m_%d.%H_%M")
	backupFile=$backupDir/backup_$now.json
	backupHistory=$backupDir/history.log

	echo -e "\n\n============== $now ================\n" > $output
	echo -e "** env:$version , graph:$graph **\n" >> $output

	cat << EOI > $input 
    g=rexster.getGraph("$graph")
	DynamicGraphSONWriter.outputGraph(g, "$backupFile")
EOI

	#execute backup
    $DIR/graphdb.sh -v $version -a start console -e $input 2>&1 >> $output
	if grep -i -q "error" $output
	then
		echo -e "[ failed ] ">> $output
		send_mail "backup failed" 
	else
		echo -e "[ ok ] : $backupFile" >> $output
		send_mail "backup succeeded" 
	fi

    cat $output >> $backupHistory
}

function send_mail 
{
    sendmail -f $mailTo -oi -t <<EOF
    To: $mailTo
    Subject $1
EOF

}

if [ $# -lt 1 ] 
then
	usage
	exit 1
fi

action=unknown
version=unknown

while getopts "a:v:" flag; do
  	case $flag in
    	a)
		action=$OPTARG;
		#echo "stop";
      		;;
	v)
		version="$OPTARG";
		#echo "version=$version";
		;;
    	\?)
		usage
      		;;
  	esac
done

shift $(( OPTIND - 1 ));

graph=$1

echo $0 will $action \"$graph\" in \"$version\"

# invoke the action

case "$action" in
	backup)
        backup $version $graph
        ;;	
	restore)
        echo "not yet implemented"
		;;
	*)
		usage;;
esac



