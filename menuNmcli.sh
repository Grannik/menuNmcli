#!/bin/bash

 E='echo -e';    # -e включить поддержку вывода Escape последовательностей
 e='echo -en';   # -n не выводить перевод строки
 trap "R;exit" 2 # 
    ESC=$( $e "\e")
   TPUT(){ $e "\e[${1};${2}H" ;}
  CLEAR(){ $e "\ec";}
# 25 возможно это 
  CIVIS(){ $e "\e[?25l";}
# это цвет текста списка перед курсором при значении 0 в переменной  UNMARK(){ $e "\e[0m";}
MARK(){ $e "\e[44m";}
# 0 это цвет списка
 UNMARK(){ $e "\e[0m";}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Эти строки задают цвет фона ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  R(){ CLEAR ;stty sane;CLEAR;};                 # в этом варианте фон прозрачный
# R(){ CLEAR ;stty sane;$e "\ec\e[37;44m\e[J";}; # в этом варианте закрашивается весь фон терминала
# R(){ CLEAR ;stty sane;$e "\ec\e[0;45m\e[";};   # в этом варианте закрашивается только фон меню
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 HEAD(){ for (( a=1; a<=39; a++ ))
  do
   TPUT $a 1
        $E "\xE2\x94\x82                                              \xE2\x94\x82";
  done
  TPUT 3 2
        $E "$(tput bold)      Справочник WIFI утилиты nmcli$(tput sgr 0)";
   TPUT 4 2
        $E "$(tput setaf 2)  network manager command-line interface    $(tput sgr 0)";
   TPUT 14 2
        $E "$(tput setaf 2)  Показать  show                            $(tput sgr 0)";
   TPUT 21 2  
        $E "$(tput setaf 2)  Состояние status                          $(tput sgr 0)";
   TPUT 25 2
        $E "$(tput setaf 2)  Cписок    list                            $(tput sgr 0)";
   TPUT 27 2
        $E "$(tput setaf 2)  Cвязь     connection                      $(tput sgr 0)";
   TPUT 33 2
        $E "$(tput setaf 2)  Псевдографический интерфейс               $(tput sgr 0)";
   TPUT 36 2
        $E "$(tput setaf 2)  Up \xE2\x86\x91 \xE2\x86\x93 Down Select Enter                  $(tput sgr 0)";
 MARK;TPUT 1 2
        $E "  Программа написана на bash tput             " ;UNMARK;}
   i=0; CLEAR; CIVIS;NULL=/dev/null
# 32 это расстояние сверху и 48 это расстояние слева
   FOOT(){ MARK;TPUT 39 2
        $E "           Grannik | 2021.07.05               ";UNMARK;}
# это управляет кнопками ввер/хвниз
 i=0; CLEAR; CIVIS;NULL=/dev/null
#
 ARROW(){ IFS= read -s -n1 key 2>/dev/null >&2
           if [[ $key = $ESC ]];then 
              read -s -n1 key 2>/dev/null >&2;
              if [[ $key = \[ ]]; then
                 read -s -n1 key 2>/dev/null >&2;
                 if [[ $key = A ]]; then echo up;fi
                 if [[ $key = B ]];then echo dn;fi
              fi
           fi
           if [[ "$key" == "$($e \\x0A)" ]];then echo enter;fi;}
# 4 и далее это отступ сверху и 48 это расстояние слева
 M0(){ TPUT  6 3; $e " Главный сайт                              ";}
 M1(){ TPUT  7 3; $e " Pуководство                               ";}
 M2(){ TPUT  8 3; $e " Запустить     службу NetworkManager       ";}
 M3(){ TPUT  9 3; $e " Перезапустить службу NetworkManager       ";}
 M4(){ TPUT 10 3; $e " Показать состояние                        ";}
 M5(){ TPUT 11 3; $e " Включить / выключить                      ";}
 M6(){ TPUT 12 3; $e " Посмотреть имя хоста                      ";}
 M7(){ TPUT 13 3; $e " Убедиться, что NetworkManager запущен     ";}
 M8(){ TPUT 15 3; $e " Показать информацию об устройствах        ";}
 M9(){ TPUT 16 3; $e " Показать информацию об устройстве         ";}
M10(){ TPUT 17 3; $e " Показать информацию о сетевых интерфейсах ";}
M11(){ TPUT 18 3; $e " Показать таблицу маршрутизации            ";}
M12(){ TPUT 19 3; $e " Показать список доступных подключений     ";}
M13(){ TPUT 20 3; $e " Показать одно подключение                 ";}
M14(){ TPUT 22 3; $e " Увидеть статус всех сетевых интерфейсов   ";}
M15(){ TPUT 23 3; $e " Cмотрим статус состояние интерфейсов      ";}
M16(){ TPUT 24 3; $e " Проверяем статус NetworkManager           ";}
M17(){ TPUT 26 3; $e " Просканировать ближайшие сети Wi-Fi       ";}
M18(){ TPUT 28 3; $e " Узнать название интерфейса                ";}
M19(){ TPUT 29 3; $e " Установить соединение с SSID              ";}
M20(){ TPUT 30 3; $e " Переключение на другую SSID               ";}
M21(){ TPUT 31 3; $e " Oбновить настройки                        ";}
M22(){ TPUT 32 3; $e " Поднять / отключить интерфейс             ";}
M23(){ TPUT 34 3; $e " Псевдографический интерфейс на Whiptail   ";}
M24(){ TPUT 35 3; $e " Показать команду терминала                ";}
M25(){ TPUT 37 3; $e " EXIT                                      ";}
# далее идет переменная LM=16 позволяющая бегать по списоку.
LM=25
   MENU(){ for each in $(seq 0 $LM);do M${each};done;}
    POS(){ if [[ $cur == up ]];then ((i--));fi
           if [[ $cur == dn ]];then ((i++));fi
           if [[ $i -lt 0   ]];then i=$LM;fi
           if [[ $i -gt $LM ]];then i=0;fi;}
REFRESH(){ after=$((i+1)); before=$((i-1))
           if [[ $before -lt 0  ]];then before=$LM;fi
           if [[ $after -gt $LM ]];then after=0;fi
           if [[ $j -lt $i      ]];then UNMARK;M$before;else UNMARK;M$after;fi
           if [[ $after -eq 0 ]] || [ $before -eq $LM ];then
           UNMARK; M$before; M$after;fi;j=$i;UNMARK;M$before;M$after;}
   INIT(){ R;HEAD;FOOT;MENU;}
     SC(){ REFRESH;MARK;$S;$b;cur=`ARROW`;}
# Функция возвращения в меню
     ES(){ MARK;$e " ENTER = main menu ";$b;read;INIT;};INIT
  while [[ "$O" != " " ]]; do case $i in
# Здесь необходимо следить за двумя перепенными 0) и S=M0 Они должны совпадать между собой и переменной списка M0().
        0) S=M0 ;SC;if [[ $cur == enter ]];then R;echo " https://developer.gnome.org/NetworkManager/stable/nmcli.html";ES;fi;;
        1) S=M1 ;SC;if [[ $cur == enter ]];then R;man nmcli;ES;fi;;
        2) S=M2 ;SC;if [[ $cur == enter ]];then R;echo "
 sudo systemctl start NetworkManager
";ES;fi;;
        3) S=M3 ;SC;if [[ $cur == enter ]];then R;echo " systemctl restart NetworkManager";ES;fi;;
        4) S=M4 ;SC;if [[ $cur == enter ]];then R;echo "
 Показать включен или выключен:
 nmcli radio wifi

 Ответ:
 ----------+----------
$(tput setaf 2) enabled  $(tput sgr 0) | включено
$(tput setaf 1) disabled $(tput sgr 0) | выключено
";ES;fi;;
        5) S=M5 ;SC;if [[ $cur == enter ]];then R;echo "
 Включить:
 nmcli radio wifi on

 Выключить:
 nmcli radio wifi off
";ES;fi;;
        6) S=M6 ;SC;if [[ $cur == enter ]];then R;echo " nmcli general hostname";ES;fi;;
        7) S=M7 ;SC;if [[ $cur == enter ]];then R;echo " nmcli general";ES;fi;;
        8) S=M8 ;SC;if [[ $cur == enter ]];then R;echo "
 nmcli device show
 nmcli dev show
";ES;fi;;
        9) S=M9 ;SC;if [[ $cur == enter ]];then R;echo " nmcli device show имя_устройства";ES;fi;;
       10) S=M10;SC;if [[ $cur == enter ]];then R;echo " ip addr show";ES;fi;;
       11) S=M11;SC;if [[ $cur == enter ]];then R;echo " ip route show match 0/0";ES;fi;;
       12) S=M12;SC;if [[ $cur == enter ]];then R;echo "
 Команда:
    nmcli connection show
 или
    nmcli con show
 или
    nmcli c s

 Посмотреть только активные соединения:
    nmcli con show -a
";ES;fi;;
       13) S=M13;SC;if [[ $cur == enter ]];then R;echo " nmcli connection show \"имя_соединения\"";ES;fi;;
       14) S=M14;SC;if [[ $cur == enter ]];then R;echo "
 Команда:
 nmcli device status
или
 nmcli dev status
 Ответ:
 -----------+------+-----------+-----------
 DEVICE     | TYPE | STATE     | CONNECTION
$(tput setaf 2) устройство | тип  | состояние | связь      $(tput sgr 0)

$(tput setaf 2)    connected $(tput sgr 0) | подключено
$(tput setaf 1) disconnected $(tput sgr 0) | не подключено
$(tput setaf 7)  unavailable $(tput sgr 0) | недоступен
$(tput setaf 7)    unmanaged $(tput sgr 0) | неуправляемый
";ES;fi;;
       15) S=M15;SC;if [[ $cur == enter ]];then R;echo " nmcli general status ";ES;fi;;
       16) S=M16;SC;if [[ $cur == enter ]];then R;echo " systemctl status NetworkManager ";ES;fi;;
       17) S=M17;SC;if [[ $cur == enter ]];then R;echo "
 Команда:
 nmcli device wifi list
или
 nmcli dev wifi list
";ES;fi;;
       18) S=M18;SC;if [[ $cur == enter ]];then R;echo "
 Команда:
 nmcli connection
или
 nmcli con
";ES;fi;;
       19) S=M19 ;SC;if [[ $cur == enter ]];then R;echo "
 Команда:
 sudo nmcli dev wifi connect имя_сети

 Команда с паролем:
 sudo nmcli dev wifi connect имя_сети password \"пароль\"

 В качестве альтернативы можно использовать параметр –ask
 sudo nmcli --ask dev wifi connect имя_сети
 Теперь система попросит вас ввести сетевой пароль, не делая его видимым.
";ES;fi;;
       20) S=M20 ;SC;if [[ $cur == enter ]];then R;echo "
 При подключении к одной сети, но надо использовать другое соединение,
 Можно отключиться, переключив соединение на «Нет» .
 Нужно будет указать SSID или, если несколько подключений с одним и тем же SSID, используйте UUID.
 nmcli con down ssid/uuid

 Чтобы подключиться к другому сохраненному соединению, просто передать опцию up в команде nmcli.
 Убедитесь, что вы указали SSID или UUID новой сети, к которой хотите подключиться.
 nmcli con up ssid/uuid
";ES;fi;;
       21) S=M21;SC;if [[ $cur == enter ]];then R;echo " nmcli connection up static";ES;fi;;
       22) S=M22;SC;if [[ $cur == enter ]];then R;echo "
 Поднять интерфейс:
 nmcli con up имя_интерфейса
 Oтключить интерфейс:
 nmcli con down имя_интерфейса
";ES;fi;;
       23) S=M23;SC;if [[ $cur == enter ]];then R;nmtui;ES;fi;;
       24) S=M24;SC;if [[ $cur == enter ]];then R;echo " nmtui ";ES;fi;;
       25) S=M25;SC;if [[ $cur == enter ]];then R;exit 0;fi;;
 esac;POS;done
