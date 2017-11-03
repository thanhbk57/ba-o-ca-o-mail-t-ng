#! /bin/bash
set -x
dm=$(date +%Y%m)
dd=$(date +%Y-%m-%d)
dd1=$(date +%Y%m%d)
dd2=$(date +%y%m%d)
dd4=$(date --date "-1 day" +%Y%m%d)
t=$(date --date "-2 day" +%Y-%m-%d)
homedir=/home/thanhnv
cd /home/thanhnv
rm -rf tempDB.tmp temphtml.tmp temp.txt
echo "ThanhNV gửi báo cáo ngày $dd" > $homedir/temphtml.tmp
echo "STT |Hệ thống/Dịch vụ |Người phụ trách |Test dịch vụ |Hoạt động của các tiến trình dịch vụ, log các tiến trình |Doanh thu, CDR |Sản lượng MO/MT |Backup |Cảnh báo bất thường |Thời gian kiểm tra" >>$homedir/solieu/solieu$dd.txt
echo "<!DOCTYPE html><html xmlns=http://www.w3.org/1999/xhtml><head><meta charset=utf-8 http-equiv=Content-Type><title></title></head><body><style type=text/css>table th {background: none repeat scroll 0 0 powderblue; border: 1px solid; color: blue;padding: 5px;text-align: center;} table td .tenpercent { width:10%; text-align:center;} table td {border: 1px solid;color: navy;padding: 6px; text-align:center;}</style><div> <table cellpadding=0 cellspacing=0 border=1><thead><tr><th>STT </th><th>Hệ thống/Dịch vụ</th><th>Người phụ trách</th><th>Test dịch vụ</th><th>Hoạt động của các tiến trình dịch vụ, log các tiến trình</th><th>Doanh thu, CDR</th><th>Sản lượng MT / MO</th><th>Backup</th><th>Cảnh báo bất thường</th><th>Thời gian kiểm tra</th></tr></thead>" >> $homedir/temphtml.tmp
#database 2.239
MyUSER239=rpthangpv
MyPASS239=mps@123
MyHOST239=10.54.2.239
DB=

MyUSER231=rpthangpv
MyPASS231=mps@123
MyHOST231=10.54.2.231
DB=

MyUSER194=rpthangpv
MyPASS194=mps@123
MyHOST194=10.54.64.194
DB=

MyUSER244=rpthangpv
MyPASS244=mps@123
MyHOST244=10.54.2.244
DB=

MyUSER10=rpthangpv
MyPASS10=mps@123
MyHOST10=10.151.190.10
DB=

MyUSER241=rpthangpv
MyPASS241=mps@123
MyHOST241=10.54.2.241
DB=

for i in $(cat /home/thanhnv/dvname.txt)
     do
                echo $i > temp.txt
                 dvname=`cut -d';' -f1 temp.txt`

#____________________________________________________________mFun________________________________________________________________
if [ "$dvname" == mFun ]
then
#count MT  "mFun"
   countMTmFun=`mysql -h $MyHOST241 -u $MyUSER241 -p$MyPASS241 <<EOF
  select r1 as "" from MonitorDB.monitor_data where monitor_command_id='3912';
EOF`

#count MO  "mFun"
   countMOmFun=`mysql -h $MyHOST241 -u $MyUSER241 -p$MyPASS241 <<EOF
  select r1 as "" from MonitorDB.monitor_data where monitor_command_id='3608';
EOF`

#count Doanh Thu mFun
 countDTmFun=`mysql -h $MyHOST241 -u $MyUSER241 -p$MyPASS241 <<EOF
  select r1 as "" from MonitorDB.monitor_data where monitor_command_id='1759';
EOF`
echo "1 |$dvname |ThangNV |Bình thường |Bình thường |$countDTmFun |$countMTmFun / $countMOmFun |Bình thường |Không|17h30" >>$homedir/solieu/solieu$dd.txt
echo "<tbody><tr><td>1</td><td>$dvname</td><td class="tenpercent">ThanhNV</td><td class="tenpercent">Bình thường</td><td class="tenpercent">Bình thường</td><td>$countDTmFun</td><td>$countMTmFun / $countMOmFun </td><td>Bình thường</td><td>Không</td><td>17h30</td></tr></tbody>" >> $homedir/temphtml.tmp

fi

#______________________________________________________________________Brandname________________________________________________________________
if [ "$dvname" == Brandname ]
then
#count MT  "Brandname"
 countBrandname=`mysql -h $MyHOST241 -u $MyUSER241 -p$MyPASS241 <<EOF
  select r1 as "" from MonitorDB.monitor_data where monitor_command_id='3924';
EOF`
echo "2 |$dvname |ThanhNV |Bình thường |Bình thường |N/a |$countBrandname / 0 |Bình thường |Không|17h30" >>$homedir/solieu/solieu$dd.txt
echo "<tbody><tr><td>2</td><td>$dvname</td><td class="tenpercent">ThanhNV</td><td class="tenpercent">Bình thường</td><td class="tenpercent">Bình thường</td><td>N/a</td><td>$countBrandname/0 </td><td>Bình thường</td><td>Không</td><td>17h30</td></tr></tbody>" >> $homedir/temphtml.tmp

fi

#_______________________________________________________________________Backup_______________________________________________________________
if [ "$dvname" == Backup ]
then
echo "3 |$dvname |DuongNT |Bình thường |Bình thường |Bình thường | N/A | Theo báo cáo hàng ngày |Bình thường |Không|17h30" >>$homedir/solieu/solieu$dd.txt
echo "<tbody><tr><td>3</td><td>$dvname</td><td class="tenpercent">DuongNT</td><td class="tenpercent">Bình thường</td><td class="tenpercent">Bình thường</td><td>N/A</td><td>Không phát sinh MO/MT  </td><td>Bình thường</td><td>Không</td><td>17h30</td></tr></tbody>" >> $homedir/temphtml.tmp

fi

#______________________________________________________________________Fastbank________________________________________________________________
if [ "$dvname" == Fastbank ]
then
#count doanhthu  "Fastbank"
   countFastbank=`mysql -h $MyHOST241 -u $MyUSER241 -p$MyPASS241 <<EOF
  select r1 as "" from MonitorDB.monitor_data where monitor_command_id='3920';
EOF`

echo "4 |$dvname |ThanhNV |Bình thường |Bình thường |$countFastbank |N/a |Bình thường |Không|17h30h" >>$homedir/solieu/solieu$dd.txt
echo "<tbody><tr><td>4</td><td>$dvname</td><td class="tenpercent">ThanhNV</td><td class="tenpercent">Bình thường</td><td class="tenpercent">Truy cập trang web bình thường</td><td>$countFastbank</td><td>N/a </td><td>Bình thường</td><td>Không</td><td>17h30</td></tr></tbody>" >> $homedir/temphtml.tmp

fi


#______________________________________________________________________Phan Mem Git________________________________________________________________
if [ "$dvname" == GIT ]
then
echo "5 |$dvname |ThanhNV |Bình thường |Bình thường |Bình thường |N/a |Bình thường |Không|17h30h" >>$homedir/solieu/solieu$dd.txt
echo "<tbody><tr><td>5</td><td>$dvname</td><td class="tenpercent">ThanhNV</td><td class="tenpercent">Bình thường</td><td class="tenpercent">Truy cập trang web bình thường</td><td>Bình thường</td><td>N/a </td><td>Bình thường</td><td>Không</td><td>17h30</td></tr></tbody>" >> $homedir/temphtml.tmp

fi

#_______________________________________________________________________SENT_MAIL_REPORT_______________________________________________________________
if [ "$dvname" == Sendmail ]
then
echo "6 |$dvname |ThanhNV |Bình thường |Bình thường |Bình thường | N/A | Không phát sinh MO/MT |Bình thường |Không|17h30" >>$homedir/solieu/solieu$dd.txt
echo "<tbody><tr><td>6</td><td>$dvname</td><td class="tenpercent">ThanhNV</td><td class="tenpercent">Bình thường</td><td class="tenpercent">Bình thường</td><td>N/A</td><td>Không phát sinh MO/MT  </td><td>Bình thường</td><td>Không</td><td>17h30</td></tr></tbody>" >> $homedir/temphtml.tmp

fi

#____________________________________________________________OCMM________________________________________________________________
if [ "$dvname" == OCMM ]
then
#count MT  "OCMM"
   countMTOCMM=`mysql -h $MyHOST241 -u $MyUSER241 -p$MyPASS241 <<EOF
select r1 as "" from MonitorDB.monitor_data where monitor_command_id='2384';
EOF`

#count MO OCMM
 countMOOCMM=`mysql -h $MyHOST241 -u $MyUSER241 -p$MyPASS241 <<EOF
 select r1 as "" from MonitorDB.monitor_data where monitor_command_id='2257';
EOF`

#count Doanh Thu OCMM
 countDTOCMM=`mysql -h $MyHOST241 -u $MyUSER241 -p$MyPASS241 <<EOF
select r1 as "" from MonitorDB.monitor_data where monitor_command_id='1980';
EOF`
echo "7 |$dvname |ThanhDV |Bình thường |Bình thường |Bình thường |$countDTOCMM |$countMTOCMM / $countMOOCMM |Bình thường |Không|17h30" >>$homedir/solieu/solieu$dd.txt
echo "<tbody><tr><td>7</td><td>$dvname</td><td class="tenpercent">ThanhDV</td><td class="tenpercent">Bình thường</td><td class="tenpercent">Bình thường</td><td>$countDTOCMM</td><td>$countMTOCMM / $countMOOCMM </td><td>Bình thường</td><td>Không</td><td>17h30</td></tr></tbody>" >> $homedir/temphtml.tmp

fi

done
echo "</table></div></body></html>" >>$homedir/temphtml.tmp
echo "Thanks!" >> $homedir/temphtml.tmp
#auto email	 

detail=$(cat $homedir/temphtml.tmp)
#echo "ThanhNV gửi báo cáo ngày $dd" >> detail1
#cat detail >> detail1
cd $homedir

#Email Alert
#database
MyUSER=admin    # USERNAME
MyPASS=mps@123       # PASSWORD
MyHOST=10.54.64.194
DB=emailserver
echo "use $DB;" > tempDB.tmp

echo 'INSERT INTO `emailserver`.`contentEmail` (`UsersId`, `FromMailId`, `title`, `description`, `detail`, `conStatus`) VALUES ("'2'", "'686884'", "'ThanhNV_Báo cáo ngày_$dd1'", "'Thanhnv_Báo cáo ngày_$dd1'",  "'$detail'",  "'0'");' >>tempDB.tmp


echo quit>>tempDB.tmp
mysql -h $MyHOST -u $MyUSER -p$MyPASS<tempDB.tmp
