import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'ru_RU': {
          'hand_button_txt': 'Проверка марок вручную',
          //
          'backlight_button_txt': 'Подсветка',
          'scan_button_txt': 'Сканировать через QR',
          'scan_button_txt_history': 'История проверок',
          'scan_button_txt_create': 'Создать место проверки',
          'onboard_btn_txt': 'Далее',
          'come_btn_txt': 'Войти как Инспектор',
          'kabinet_inspect_buttom_user': 'Кабинет Инспектора',
          //
          'first_clide_txt':
              'e-Sapa - это мобильное приложение для устройств iOS и Android, позволяющее проверить легальность алкогольной продукции. e-Sapa',
          'second_clide_txt':
              'Сканируй учетно-контрольную марку. Приложение определит легальность',
          'third_clide_txt':
              'Если ты обнаружил контрафакт или нарушение , сообщи об этом через приложение',

          //buttom_qr_screen_history
          'exit_alert_title_txt':
              'Для входа в кабинет инспектора вам необходимо авторизоваться',
          'exit_alert_title_txt_kabinet':
              'Вы действительно хотите выйти с учетной записи?',
          'exit_buttom_user': 'Выйти',
          'exit_kabinet_inspec_buttom_user': 'Выйти',
          'exit_alert_txt': 'Выйти',
          'exit_alert_txt_yes': 'Продолжить',
          'exit_alert_txt_yes_kabinet': 'Да',
          'exit_alert_txt_no': 'Отмена',

          //
          'first_clide_big_txt': 'E-sapa',
          'second_clide_big_txt': 'Sсan QR',
          'third_clide_big_txt': 'Нарушения',
          //
          'scan_appbar_txt': '',
          'hand_appbar_txt': 'Проверка марок вручную',
          'hand_kgd_txt_new': 'УКМ нового образца',
          'hand_kgd_txt': 'УКМ старого образца',
          'seriya_txt': 'серия',
          'momer_txt': 'номер',
          'check_btn_txt': 'Отправить',
          'message_btn_text': 'Отправить',
          //
          'lang_screen_text': 'Добро пожаловать в СУАП\n',
          'lang_screen_subtext': 'Выберите язык:',
          //
          'lang_screen_btn_text': 'Сохранить',
          //
          'appbar_next_text': 'Пропустить',
          //
          'home_screen_text': 'Выберите метод:',
          'home_screen_sub_text': 'Проверки алкогольной продукции',
          //
          'hand_screen_txt': 'Выберите вид учетно-контрольной марки',
          'appbar_qr_screen_txt': 'Сканирование марки',
          'qr_screen_txt_title':
              'Поместите QR-код в центр вашей камеры, и QR-код будет автоматически отсканирован',
          'buttom_qr_screen_history': 'История\nСканирования',
          'flash_icon_txt_on': 'Вспышка: вкл.',
          'flash_icon_txt_off': 'Вспышка: выкл.',
          //
          'hand_scan_btn': 'Проверка\nвручную',
          //
          'appbar_txt_history': 'История сканирования',
          'card_seria_txt': 'Серя имарки: ',
          'card_nomer_txt': 'Номер акцизы: ',
          'card_organization_txt': 'Производитель: ',
          //
          'login_screen_subtitle_txt': 'Войдите с помощью ИИН и пароля',
          'Iin_txt': 'ИИН',
          'fargot_buttom_txt': 'Забыли пароль?',

          'fargot_buttom_txt_sub':
              'Введите информацию, которая была указана при регистрации. Мы пришлем инструкцию по созданию нового пароля.',
          'enter_email_hint': 'Введите вашу электронную почту',
          'message_screen_app_text': 'Техническая поддержка',

          //

          'message_screen_text':
              'Если у вас возникли проблемы с использованием данного приложения, обратитесь к нам',

          //Place of inspect scr
          'place_of_scr_appbar': 'Место проверки',
          'place_of_scr_title': 'Создание место проверки',
          'place_of_scr_subtitle': '* - обязательные поля',

          // place of inspec form
          'place_of_scr_name': 'Наименование *',
          'place_of_scr_iin': 'ИИН/БИН *',
          'place_of_scr_place': 'Область *',
          'place_of_scr_city': 'Город, населенный пункт *',
          'place_of_scr_street': 'Улица *',
          'place_of_scr_home': 'Дом *',
          'place_of_scr_build': 'Корпус, квартира',
          'place_of_scr_info': 'Дополнительная информация',
          'place_of_scr_pred': 'Предписание *',
          'place_of_scr_dropdawn': 'Выбрать',
          'place_of_scr_btn': 'Начать проверку',
        },
        'kk_KZ': {
          'scan_button_txt': 'QR арқылы сканерлеу',
          'hand_button_txt': 'Маркаларды қолмен тексеру',
          'backlight_button_txt': 'Артқы жарық',
          'scan_button_txt_history': 'Тарихты тексеру',
          'scan_button_txt_create': 'Тексеру орнын жасаңыз',
          'onboard_btn_txt': 'Әрі қарай',
          'come_btn_txt': 'Инстектор ретінде кіріңіз',
          'kabinet_inspect_buttom_user': 'Инспекторлық кеңсе',

          //
          'first_clide_txt':
              'Е-Sapa – бұл алкоголь өнімдерінің заңдылығын тексеруге мүмкіндік беретін iOS және Android құрылғыларына арналған мобильді қосымша.',
          'second_clide_txt':
              'Сканерлеу Scan QR Есептік-бақылау маркасын сканерлеңіз. Заңдылықты анықтау қосымшасы',
          'third_clide_txt':
              'Контрафактіні немесе бұзушылықты анықтаған жағдайда, бұл туралы қосымша арқылы хабарлаңыз',

          'exit_alert_title_txt':
              'Осы есептік жазбадан шынымен шыққыңыз келе ме?',
          'exit_alert_title_txt_kabinet':
              'Тіркелгіңізден шынымен шыққыңыз келе ме?',
          'exit_alert_txt': 'Шығу',
          'exit_alert_txt_yes': 'Иә',
          'exit_alert_txt_yes_kabinet': 'Иә',
          'exit_alert_txt_no': 'Жою',
          'exit_kabinet_inspec_buttom_user': 'Шығу',
          //
          'exit_buttom_user': 'Шығу',

          'scan_appbar_txt': '',
          'hand_appbar_txt': 'Маркаларды қолмен тексеру',
          'hand_kgd_txt_new': 'Жаңа үлгідегі ЕБМ',
          'hand_kgd_txt': 'Ескі үлгідегі ЕБМ',
          'seriya_txt': 'сериясы',
          'momer_txt': 'сан',
          'check_btn_txt': 'Тексеру',
          'message_btn_text': 'Жіберу',
          //
          'first_clide_big_txt': 'E-sapa',
          'second_clide_big_txt': 'Sсan QR',
          'third_clide_big_txt': 'Бұзушылықтар',
          //
          'lang_screen_text':
              'Алкоголь өнімдерін есепке алу жүйесіне қош келдіңіз!',
          'lang_screen_subtext': 'Тілді таңдаңыз:',
          //
          'lang_screen_btn_text': 'Сақтау',
          //
          'appbar_next_text': 'Өткізіп жіберу',
          //
          'home_screen_text': 'Әдісті таңдаңыз:',
          'home_screen_sub_text': 'Алкоголь өнімдерін тексеру',
          //
          'hand_screen_txt': 'Есепке алу-бақылау маркасының түрін таңдаңыз',
          'appbar_qr_screen_txt': 'Марканы сканерлеу',
          'qr_screen_txt_title':
              'QR кодын камераның ортасына қойыңыз, сонда QR коды автоматты түрде сканерленеді',
          'buttom_qr_screen_history': 'Сканерлеу\nТарихы',
          //
          'flash_icon_txt_on': 'Жарқыл: қосулы.',
          'flash_icon_txt_off': 'Жарқыл: өшірулі.',
          //
          'hand_scan_btn': 'Қолмен\nтексеру',
          //
          'appbar_txt_history': 'Тарихты сканерлеу',
          'card_seria_txt': 'Акциздер сериясы: ',
          'card_nomer_txt': 'Акциз нөмірі: ',
          'card_organization_txt': 'Өндіруші:  ',
          //
          'login_screen_subtitle_txt': 'ЖСН және пароль арқылы кіріңіз',
          'Iin_txt': 'ЖСН',
          'fargot_buttom_txt': 'Парольді ұмыттыңыз ба?',
          'fargot_buttom_txt_sub':
              'Тіркеу кезінде көрсетілген ақпаратты енгізіңіз. Біз жаңа пароль жасау туралы нұсқаулық жібереміз.',
          'enter_email_hint': 'Электрондық поштаңызды енгізіңіз',

          //

          'message_screen_text':
              'Егер сізде осы қолданбаны пайдалануда қиындықтар туындаса, бізге хабарласыңыз',
          'message_screen_app_text': 'Қолдау қызметі',

          //Place of inspect scr
          'place_of_scr_appbar': 'Орналасқан жерді тексеріңіз',
          'place_of_scr_title': 'Тексеру орнын құру',
          'place_of_scr_subtitle': '* - міндетті өрістер',

          // place of inspec form
          'place_of_scr_name': 'Компанияның атауы *',
          'place_of_scr_iin': 'ЖСН/БСН *',
          'place_of_scr_place': 'Аймақ *',
          'place_of_scr_city': 'Қала *',
          'place_of_scr_street': 'Көше *',
          'place_of_scr_home': 'Үй *',
          'place_of_scr_build': 'Ғимарат немесе пәтер',
          'place_of_scr_info': 'Қосымша ақпарат',
          'place_of_scr_pred': 'Ұйғарым *',
          'place_of_scr_dropdawn': 'Тізімнен таңдаңыз *',
          'place_of_scr_btn': 'Тексеруді бастаңыз',
        },
      };
}
