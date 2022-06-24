# Path
PHOME="$TOME/Module/YouTube-Cli"

# Command
cat << HiH | sed2
<group>
<page config-sh=". $PHOME/home.sh" id="$RANDOM" >
<title>ReVanced CLI</title>
<desc>Chuyển đổi YouTube thường thành YouTube mod</desc>
<option reload="true" id="kk" >Cập nhật toàn bộ</option>
<handler>
# Start code
if [ "€menu_id" == "kk" ];then
ecgi "€loading"
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

fi
# End code
</handler></page></group>
HiH
