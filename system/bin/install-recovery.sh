#!/system/bin/sh
  echo 1 > /sys/module/sec/parameters/recovery_done
if ! applypatch -c EMMC:/dev/block/platform/mtk-msdc.0/11230000.MSDC0/by-name/recovery:9140224:e0006799d653725389e78c990720f5245cb28077; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/mtk-msdc.0/11230000.MSDC0/by-name/boot:8173568:d7d4ed5f4e8504d8a457669b345dd323c5410b4c EMMC:/dev/block/platform/mtk-msdc.0/11230000.MSDC0/by-name/recovery e0006799d653725389e78c990720f5245cb28077 9140224 d7d4ed5f4e8504d8a457669b345dd323c5410b4c:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
  if applypatch -c EMMC:/dev/block/platform/mtk-msdc.0/11230000.MSDC0/by-name/recovery:9140224:e0006799d653725389e78c990720f5245cb28077; then
        echo 0 > /sys/module/sec/parameters/recovery_done
        log -t recovery "Install new recovery image completed"
        
  if applysig /system/etc/recovery.sig recovery; then
    sync
    log -t recovery "Apply recovery image signature completed"
  else
    log -t recovery "Apply recovery image signature fail!!"
  fi
  
  else
        echo 2 > /sys/module/sec/parameters/recovery_done
        log -t recovery "Install new recovery image not completed"
  fi
else
  log -t recovery "Recovery image already installed"
fi
