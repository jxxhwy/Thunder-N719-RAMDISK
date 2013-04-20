#!/sbin/busybox sh


mount -o remount,rw /system
/sbin/busybox mount -t rootfs -o remount,rw rootfs

# Run Init Scripts
echo 2 > /sys/devices/system/cpu/sched_mc_power_savings

echo 90 > /proc/sys/vm/swappiness
mkdir -p /mnt/ntfs
chmod 777 /mnt/ntfs
mount -o mode=0777,gid=1000 -t tmpfs tmpfs /mnt/ntfs
if [ -d /system/etc/init.d ]; then
  /sbin/busybox run-parts /system/etc/init.d
fi;

/sbin/busybox mount -t rootfs -o remount,ro rootfs
mount -o remount,ro /system
