while [ "$(getprop sys.boot_completed | tr -d '\r')" != "1" ]; do sleep 1; done
sleep 1

sqlite3 () {
/data/data/com.kakathic.shells/files/TOME/bin/sqlite3 "$@"
}

TOff () {

base_path="/data/adb/YouTube/$2"
stock_path=$( pm path $1 | grep base | sed 's/package://g' )

if [ "$stock_path" ];then
chcon u:object_r:apk_data_file:s0 $base_path
mount -o bind $base_path $stock_path

PS=com.android.vending
DB=/data/data/$PS/databases
LDB=$DB/library.db
LADB=$DB/localappstate.db
PK=$1
GET_LDB=$(sqlite3 $LDB "SELECT doc_id,doc_type FROM ownership" | grep $PK | head -n 1 | grep -o 25)

# Main script
if [ "$GET_LDB" != "25" ]; then
	# Disable Play store
	cmd appops set --uid $PS GET_USAGE_STATS ignore
	pm disable $PS > /dev/null 2>&1
	
	# Update database
	sqlite3 $LDB "UPDATE ownership SET doc_type = '25' WHERE doc_id = '$PK'";
	sqlite3 $LADB "UPDATE appstate SET auto_update = '2' WHERE package_name = '$PK'";
	
	# Remove cache
	rm -rf /data/data/$PS/cache/*

	# Re-enable Play store
	pm enable $PS > /dev/null 2>&1
fi
fi
}

TOff com.google.android.youtube revancedY.apk
TOff com.google.android.apps.youtube.music revancedM.apk