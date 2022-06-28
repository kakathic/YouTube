# Path
PHOME="$TOME/Module/YouTube-Cli"

if [ ! -e $PHOME/lib/prebuilt ];then
mkdir -p $PHOME/lib/prebuilt/linux
echo "exec $TOME/bin/aapt2 \"\$@\"" > $PHOME/lib/prebuilt/linux/aapt2
echo "exec $TOME/bin/aapt2 \"\$@\"" > $PHOME/lib/prebuilt/linux/aapt2_64
echo "exec $TOME/bin/aapt \"\$@\"" > $PHOME/lib/prebuilt/linux/aapt
echo "exec $TOME/bin/aapt \"\$@\"" > $PHOME/lib/prebuilt/linux/aapt_64
fi

if [ ! -e $PHOME/lib/revanced-cli.jar ];then
Tv1="$(Xem https://github.com/revanced/revanced-cli/releases | grep '/releases/download' | grep -m1 '.jar' | cut -d \" -f2)"
Taive "https://github.com$Tv1" $PHOME/lib/revanced-cli.jar
if [ -e $PHOME/lib/revanced-cli.jar ];then
cd $PHOME/lib
zip -qr $PHOME/lib/revanced-cli.jar -d prebuilt/windows/* prebuilt/macosx/*
zip -qr $PHOME/lib/revanced-cli.jar prebuilt
fi
fi

if [ ! -e $PHOME/lib/revanced-patches.jar ];then
Tv2="$(Xem https://github.com/revanced/revanced-patches/releases | grep '/releases/download' | grep -m1 '.jar' | cut -d \" -f2)"
Taive "https://github.com$Tv2" $PHOME/lib/revanced-patches.jar
fi

if [ ! -e $PHOME/lib/revanced-integrations.apk ];then
Tv3="$(Xem https://github.com/revanced/revanced-integrations/releases | grep '/releases/download' | grep -m1 '.apk' | cut -d \" -f2)"
Taive "https://github.com$Tv3" $PHOME/lib/revanced-integrations.apk
fi


revanced="java -jar $PHOME/lib/revanced-cli.jar"

cat << HiH | sed2
<?xml version="1.0" encoding="UTF-8" ?>
<items>

<text/>
<text title="Version ReVanced Cli" desc-sh="$revanced -V"/>

<group>
<action >
<title>Tool Cli</title>
<desc>Import YouTube apk file it will automatically mod and install </desc>
<param name="ytmod" value-sh="Xset linkyt" type="file" title="File" editable="true" suffix="apk"/>
<param name="ncyt" value-sh="Xset linkyt2" type="text" title="Advanced" placeholder="-h -V -e v.v"/>
<param name="microg" title="Custom" label="Microg support" value-sh="Xset microg" type="bool" />
<param name="amoled" label="Amoled" value-sh="Xset amoled" type="bool" />
<param name="icons" label="ReVanced icon" value-sh="Xset icons" type="bool" />
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
[ "€icons" == 1 ] || Addk="€Addk -e custom-branding"

ecgi "€duonglink: €ytmod\n"
$revanced €ncyt €Addk --mount -m $PHOME/lib/revanced-integrations.apk -b $PHOME/lib/revanced-patches.jar -a "€ytmod" -o "$TOME/tmp/reMod.apk" -t $TOME/tmp 2>&1

Tencalss=€(aapt dump badging "$TOME/tmp/reMod.apk" | tr ' ' '\n' | grep -m1 'name=' | cut -d \' -f2)

cp -rf $PHOME/lib/service.d.sh /data/adb/service.d/YouTube.sh
cp -rf $PHOME/lib/post-fs-data.d.sh /data/adb/post-fs-data.d/YouTube.sh
chmod -R 777 /data/adb/*/YouTube.sh

if [ "€Tencalss" == "com.google.android.youtube" ];then
echo "INFO: Install €Tencalss"

mkdir -p /data/adb/YouTube
[ "$ARCH" == "arm64" ] && vkhk="-d lib/x86_64/* lib/x86/* lib/armeabi-v7a/*" || vkhk="-d lib/x86_64/* lib/x86/* lib/arm64-v8a/*"
zip -qr "$TOME/tmp/reMod.apk" €vkhk
zipalign -f 4 "$TOME/tmp/reMod.apk" "/data/adb/YouTube/revancedY.apk"
cp -rf "€ytmod" "$PHOME/lib/stock.apk"

chcon u:object_r:apk_data_file:s0 "/data/adb/YouTube/revancedY.apk"
chcon u:object_r:apk_data_file:s0 "$PHOME/lib/stock.apk"

for Tkvi in €( find /data/app | grep €Tencalss | grep 'base.apk' ); do
[ "€Tkvi" ] && umount -l "€Tkvi"
done

pm uninstall €Tencalss

for Vhkdd in €(find /data/app -name *€Tencalss*); do
[ "€Vhkdd" ] && rm -fr "€Vhkdd"
done

pm install -r "$PHOME/lib/stock.apk"
rm -fr "$PHOME/lib/stock.apk"
su -mm -c mount -o bind "/data/adb/YouTube/revancedY.apk" "€( pm path €Tencalss | grep base | sed 's/package://g' )"

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

<group>
<action >
<title>Uninstall</title>
<desc>It will remove the YouTube app or YouTube music</desc>
<param name="remo" option-sh="echo 'com.google.android.youtube|YouTube'; echo 'com.google.android.apps.youtube.music|YouTube music'"/>
<set>
for Tkvi in €( find /data/app | grep €remo | grep 'base.apk' ); do
[ "€Tkvi" ] && umount -l "€Tkvi"
done

pm uninstall €remo

for Vhkdd in €(find /data/app -name *€remo*); do
[ "€Vhkdd" ] && rm -fr "€Vhkdd"
done
</set>
</action>
</group>

<text desc-sh="echo; $revanced -b $PHOME/lib/revanced-patches.jar -l 2>&1; echo; $revanced -h"/>

</items>
HiH
