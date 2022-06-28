# Path
PHOME="$TOME/Module/YouTube-Cli"

# Command
cat << HiH | sed2
<group>
<page locked="$RROOT" config-sh=". $PHOME/home.sh" id="$RANDOM" >
<title>ReVanced Cli</title>
<desc>Convert regular YouTube to YouTube mod</desc>
<option reload="true" auto-off="true" id="kk" >Full update</option>
<option type="default" id="k1" >Patch information</option>
<lock>[ $VROOT == 1 ] && echo 0 || echo "$rootc"</lock>
<handler>
# Start code
if [ "€menu_id" == "kk" ];then
ecgi "€loading\n"
Tv1="€(Xem https://github.com/revanced/revanced-cli/releases | grep '/releases/download' | grep -m1 '.jar' | cut -d \" -f2)"
Taive "https://github.com€Tv1" $PHOME/lib/revanced-cli.jar
if [ -e $PHOME/lib/revanced-cli.jar ];then
echo 'revanced-cli ok'
cd $PHOME/lib
zip -qr $PHOME/lib/revanced-cli.jar -d prebuilt/windows/* prebuilt/macosx/*
zip -qr $PHOME/lib/revanced-cli.jar prebuilt
else
echo 'revanced-cli error'
fi

Tv2="€(Xem https://github.com/revanced/revanced-patches/releases | grep '/releases/download' | grep -m1 '.jar' | cut -d \" -f2)"
Taive "https://github.com€Tv2" $PHOME/lib/revanced-patches.jar
[ -e $PHOME/lib/revanced-patches.jar ] && echo 'revanced-patches ok' || echo 'revanced-patches error'

Tv3="€(Xem https://github.com/revanced/revanced-integrations/releases | grep '/releases/download' | grep -m1 '.apk' | cut -d \" -f2)"
Taive "https://github.com€Tv3" $PHOME/lib/revanced-integrations.apk
[ -e $PHOME/lib/revanced-integrations.apk ] && echo 'revanced-integrations ok' || echo 'revanced-integrations error'

Taive "https://github.com/kakathic/YouTube/archive/refs/heads/Cli.zip" "$TEMP_DIR/Test.zip"
[ -e "$TEMP_DIR/Test.zip" ] && unzip -o "$TEMP_DIR/Test.zip" -d "$TOME/Module" || Thoat "Cập nhật dữ liệu thất bại, vui lòng kiểm tra lại mạng!"
rm -fr "$TEMP_DIR"/*
chmod -R 777 $PHOME
else
java -jar $PHOME/lib/revanced-cli.jar --help -b $PHOME/lib/revanced-patches.jar -l 2>&1
fi
# End code
</handler></page></group>
HiH
