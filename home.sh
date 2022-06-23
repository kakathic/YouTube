# Path
PHOME="$TOME/Module/YouTube"

revanced="java -jar $PHOME/lib/revanced-cli.jar"

cat << HiH | sed2
<?xml version="1.0" encoding="UTF-8" ?>
<items>

<text/>
<text title="Phiên bản ReVanced CLi" desc-sh="$revanced -V ;echo"/>

<group>
<action >
<title>YouTube Mod</title>
<desc>Nhập tệp tin YouTube gốc nó sẽ mod và tự cài đặt</desc>
<param name="ytmod" value-sh="Xset linkyt" type="file" title="Tệp tin" editable="true" suffix="apk"/>
<param name="ncyt" value-sh="Xset linkyt2" type="text" title="Nâng cao" placeholder="-h -V -e v.v"/>
<param name="microg" title="Tùy chỉnh" label="Microg support" value-sh="Xset microg" type="bool" />
<param name="amoled" label="Amoled" value-sh="Xset amoled" type="bool" />
<param name="icons" label="YouTube icon" value-sh="Xset icons" type="bool" />
<param name="tuychinh1" label="Default" value-sh="Xset tuychinh1" type="bool" />
<set>
Tset linkyt "€ytmod"
Tset linkyt2 "€ncyt"
Tset microg "€microg"
Tset icons "€icons"
Tset amoled "€amoled"

[ "€microg" == 1 ] || Addk='-e microg-support'
[ "€amoled" == 1 ] || Addk="€Addk -e amoled"
[ "€tuychinh1" == 1 ] || Addk="€Addk -e disable-create-button -e disable-shorts-button -e hide-cast-button"

ecgi "€duonglink: €ytmod\n"
$revanced €ncyt €Addk --mount -m $PHOME/lib/revanced-integrations.apk -b $PHOME/lib/revanced-patches.jar -a "€ytmod" -o "$TOME/tmp/reMod.apk" -t $TOME/tmp 2>&amp;1

Tencalss=€(aapt dump badging "$TOME/tmp/reMod.apk" | tr ' ' '\n' | grep -m1 'name=' | cut -d \' -f2)

[ "€icons" == 1 ] && cd $PHOME/lib
[ "€icons" == 1 ] && zip -qr "$TOME/tmp/reMod.apk" res

cp -rf $PHOME/lib/service.d.sh /data/adb/service.d/YouTube.sh
cp -rf $PHOME/lib/post-fs-data.d.sh /data/adb/post-fs-data.d/YouTube.sh
chmod -R 777 /data/adb/*/YouTube.sh

if [ "€Tencalss" == "com.google.android.youtube" ];then
echo "INFO: Install €Tencalss"

mkdir -p /data/adb/YouTube
zip -qr "$TOME/tmp/reMod.apk" -d lib/x86_64/* lib/x86/*
zipalign -f 4 "$TOME/tmp/reMod.apk" "/data/adb/YouTube/revancedY.apk"
cp -rf "€ytmod" "$PHOME/lib/stock.apk"

pm uninstall €Tencalss
chcon u:object_r:apk_data_file:s0 "/data/adb/YouTube/revancedY.apk"
chcon u:object_r:apk_data_file:s0 "$PHOME/lib/stock.apk"

for Tkvi in €(find /data/app/*/*€Tencalss* -name 'base.apk'); do
umount -l "€Tkvi"
done

for Vhkdd in €(find /data/app -name *€Tencalss*); do
rm -fr "€Vhkdd"
done

pm install -r "$PHOME/lib/stock.apk"
rm -fr "$PHOME/lib/stock.apk"
su -mm -c mount -o bind "/data/adb/YouTube/revancedY.apk" "€(find /data/app/*/*€Tencalss* -name 'base.apk')"

PS=com.android.vending
DB=/data/data/€PS/databases
LDB=€DB/library.db
LADB=€DB/localappstate.db
PK=€Tencalss
GET_LDB=€(sqlite3 €LDB "SELECT doc_id,doc_type FROM ownership" | grep €PK | head -n 1 | grep -o 25)

# Main script
if [ "€GET_LDB" != "25" ]; then
	# Disable Play store
	cmd appops set --uid €PS GET_USAGE_STATS ignore
	pm disable €PS
	
	# Update database
	sqlite3 €LDB "UPDATE ownership SET doc_type = '25' WHERE doc_id = '€PK'";
	sqlite3 €LADB "UPDATE appstate SET auto_update = '2' WHERE package_name = '€PK'";
	
	# Remove cache
	rm -rf /data/data/€PS/cache/*

	# Re-enable Play store
	pm enable €PS
fi
elif [ "€Tencalss" == "app.revanced.android.youtube" ];then
zipalign -f 4 "$TOME/tmp/reMod.apk" "$TOME/tmp/reMod2.apk"
apksigner apk testkey "$TOME/tmp/reMod2.apk" "$TOME/tmp/reMod3.apk"
chcon u:object_r:apk_data_file:s0 "$TOME/tmp/reMod3.apk"
pm install -r -d "$TOME/tmp/reMod3.apk"
else
echi "Error"
fi

</set>
</action>
</group>



</items>
HiH