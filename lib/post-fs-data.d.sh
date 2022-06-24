
Vipu () {
while read line; do echo ${line} | grep $1 | awk '{print $2}' | xargs umount -l; done< /proc/mounts
}

Vipu com.google.android.youtube
Vipu com.google.android.apps.youtube.music