
#Область СлужебныйПрограммныйИнтерфейс

#Область ЗначенияСубконто

Функция СубконтоНоменклатурныеГруппы(Счет) Экспорт

	Если ТипЗнч(Счет) =  Тип("ПланСчетовСсылка.Хозрасчетный") Тогда
		Субконто = ПредопределенноеЗначение("ПланВидовХарактеристик.ВидыСубконтоХозрасчетные.НоменклатурныеГруппы");
	ИначеЕсли ТипЗнч(Счет) =  Тип("ПланСчетовСсылка.бит_Бюджетирование") Тогда
		Субконто = ПредопределенноеЗначение("ПланВидовХарактеристик.бит_ВидыСубконтоБюджетирования.НоменклатурныеГруппы");
	ИначеЕсли ТипЗнч(Счет) =  Тип("ПланСчетовСсылка.бит_Дополнительный_1") Тогда
		Субконто = ПредопределенноеЗначение("ПланВидовХарактеристик.бит_ВидыСубконтоДополнительные_1.НоменклатурныеГруппы");
	ИначеЕсли ТипЗнч(Счет) =  Тип("ПланСчетовСсылка.бит_Дополнительный_2") Тогда
		Субконто = ПредопределенноеЗначение("ПланВидовХарактеристик.бит_ВидыСубконтоДополнительные_2.НоменклатурныеГруппы");
	ИначеЕсли ТипЗнч(Счет) =  Тип("ПланСчетовСсылка.бит_Дополнительный_3") Тогда
		Субконто = ПредопределенноеЗначение("ПланВидовХарактеристик.бит_ВидыСубконтоДополнительные_3.НоменклатурныеГруппы");
	ИначеЕсли ТипЗнч(Счет) =  Тип("ПланСчетовСсылка.бит_Дополнительный_4") Тогда
		Субконто = ПредопределенноеЗначение("ПланВидовХарактеристик.бит_ВидыСубконтоДополнительные_4.НоменклатурныеГруппы");
	ИначеЕсли ТипЗнч(Счет) =  Тип("ПланСчетовСсылка.бит_Дополнительный_5") Тогда
		Субконто = ПредопределенноеЗначение("ПланВидовХарактеристик.бит_ВидыСубконтоДополнительные_5.НоменклатурныеГруппы");
	Иначе
		Субконто = Неопределено;
	КонецЕсли;
	
	Возврат Субконто;

КонецФункции
 
Функция СубконтоДоговоры(Счет) Экспорт

	Если ТипЗнч(Счет) =  Тип("ПланСчетовСсылка.Хозрасчетный") Тогда
		Субконто = ПредопределенноеЗначение("ПланВидовХарактеристик.ВидыСубконтоХозрасчетные.НоменклатурныеГруппы");
	ИначеЕсли ТипЗнч(Счет) =  Тип("ПланСчетовСсылка.бит_Бюджетирование") Тогда
		Субконто = ПредопределенноеЗначение("ПланВидовХарактеристик.бит_ВидыСубконтоБюджетирования.ДоговорыКонтрагентов");
	ИначеЕсли ТипЗнч(Счет) =  Тип("ПланСчетовСсылка.бит_Дополнительный_1") Тогда
		Субконто = ПредопределенноеЗначение("ПланВидовХарактеристик.бит_ВидыСубконтоДополнительные_1.ДоговорыКонтрагентов");
	ИначеЕсли ТипЗнч(Счет) =  Тип("ПланСчетовСсылка.бит_Дополнительный_2") Тогда
		Субконто = ПредопределенноеЗначение("ПланВидовХарактеристик.бит_ВидыСубконтоДополнительные_2.ДоговорыКонтрагентов");
	ИначеЕсли ТипЗнч(Счет) =  Тип("ПланСчетовСсылка.бит_Дополнительный_3") Тогда
		Субконто = ПредопределенноеЗначение("ПланВидовХарактеристик.бит_ВидыСубконтоДополнительные_3.ДоговорыКонтрагентов");
	ИначеЕсли ТипЗнч(Счет) =  Тип("ПланСчетовСсылка.бит_Дополнительный_4") Тогда
		Субконто = ПредопределенноеЗначение("ПланВидовХарактеристик.бит_ВидыСубконтоДополнительные_4.ДоговорыКонтрагентов");
	ИначеЕсли ТипЗнч(Счет) =  Тип("ПланСчетовСсылка.бит_Дополнительный_5") Тогда
		Субконто = ПредопределенноеЗначение("ПланВидовХарактеристик.бит_ВидыСубконтоДополнительные_5.ДоговорыКонтрагентов");
	Иначе
		Субконто = Неопределено;
	КонецЕсли;
	
	Возврат Субконто;

КонецФункции

Функция ЭтоВидСубконто(Значение) Экспорт

	Типы = Новый Массив(); 
	Типы.Добавить(Тип("ПланВидовХарактеристикСсылка.бит_ВидыСубконтоБюджетирования"));
	Типы.Добавить(Тип("ПланВидовХарактеристикСсылка.бит_ВидыСубконтоДополнительные_1"));
	Типы.Добавить(Тип("ПланВидовХарактеристикСсылка.бит_ВидыСубконтоДополнительные_2"));
	Типы.Добавить(Тип("ПланВидовХарактеристикСсылка.бит_ВидыСубконтоДополнительные_3"));
	Типы.Добавить(Тип("ПланВидовХарактеристикСсылка.бит_ВидыСубконтоДополнительные_4"));
	Типы.Добавить(Тип("ПланВидовХарактеристикСсылка.бит_ВидыСубконтоДополнительные_5"));

	ОписаниеТипов = Новый ОписаниеТипов(Типы);
	Возврат ОписаниеТипов.СодержитТип(ТипЗнч(Значение));
	
КонецФункции
 
#КонецОбласти 

Функция ПолучитьСвойстваСчета(Знач Счет) Экспорт

	Если ТипЗнч(Счет) =  Тип("ПланСчетовСсылка.Хозрасчетный") Тогда
		ДанныеСчета = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Счет);
	ИначеЕсли ТипЗнч(Счет) =  Тип("ПланСчетовСсылка.бит_Бюджетирование") Тогда
		ДанныеСчета = ПолучитьСвойстваСчетаБюджетирование(Счет);
	ИначеЕсли ТипЗнч(Счет) =  Тип("ПланСчетовСсылка.бит_Дополнительный_1") Тогда
		ДанныеСчета = ПолучитьСвойстваСчетаУправленческий(Счет);
	ИначеЕсли ТипЗнч(Счет) =  Тип("ПланСчетовСсылка.бит_Дополнительный_2") Тогда
		ДанныеСчета = ПолучитьСвойстваСчетаДополнительный2(Счет);
	ИначеЕсли ТипЗнч(Счет) =  Тип("ПланСчетовСсылка.бит_Дополнительный_3") Тогда
		ДанныеСчета = ПолучитьСвойстваСчетаДополнительный3(Счет);
	ИначеЕсли ТипЗнч(Счет) =  Тип("ПланСчетовСсылка.бит_Дополнительный_4") Тогда
		ДанныеСчета = ПолучитьСвойстваСчетаДополнительный4(Счет);
	ИначеЕсли ТипЗнч(Счет) =  Тип("ПланСчетовСсылка.бит_Дополнительный_5") Тогда
		ДанныеСчета = ПолучитьСвойстваСчетаДополнительный5(Счет);
	ИначеЕсли ЕстьТиповойПланСчетовМеждународный() Тогда
		ДанныеСчета = ПолучитьСвойстваСчетаМеждународный(Счет);
	Иначе
		ДанныеСчета = ДанныеСчетаПоУмолчанию();
	КонецЕсли;
	
	Возврат ДанныеСчета;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область СвойстваСчетов

Функция ДанныеСчетаПоУмолчанию()

	ДанныеСчета = Новый Структура;
	ДанныеСчета.Вставить("Наименование"                   , "");
	ДанныеСчета.Вставить("Код"                            , "");
	ДанныеСчета.Вставить("КодБыстрогоВыбора"              , "");
	ДанныеСчета.Вставить("Вид"                            , Неопределено);
	ДанныеСчета.Вставить("Забалансовый"                   , Ложь);
	ДанныеСчета.Вставить("ЗапретитьИспользоватьВПроводках", Ложь);
	ДанныеСчета.Вставить("Валютный"                       , Ложь);
	ДанныеСчета.Вставить("Количественный"                 , Ложь);
	ДанныеСчета.Вставить("УчетПоПодразделениям"           , Ложь);
	ДанныеСчета.Вставить("НалоговыйУчет"                  , Ложь);
	ДанныеСчета.Вставить("КоличествоСубконто"             , 0);
		
	Возврат Новый ФиксированнаяСтруктура(ДанныеСчета);
	
КонецФункции

Функция ПолучитьСвойстваСчетаБюджетирование(Знач Счет)

	ДанныеСчета = Новый Структура;
	ДанныеСчета.Вставить("Ссылка"                         , ПланыСчетов.бит_Бюджетирование.ПустаяСсылка());
	ДанныеСчета.Вставить("Наименование"                   , "");
	ДанныеСчета.Вставить("Код"                            , "");
	ДанныеСчета.Вставить("КодБыстрогоВыбора"              , "");
	ДанныеСчета.Вставить("Родитель"                       , ПланыСчетов.бит_Бюджетирование.ПустаяСсылка());
	ДанныеСчета.Вставить("Вид"                            , Неопределено);
	ДанныеСчета.Вставить("Забалансовый"                   , Ложь);
	ДанныеСчета.Вставить("ЗапретитьИспользоватьВПроводках", Ложь);
	ДанныеСчета.Вставить("Валютный"                       , Ложь);
	ДанныеСчета.Вставить("Количественный"                 , Ложь);
	ДанныеСчета.Вставить("УчетПоПодразделениям"           , Ложь);
	ДанныеСчета.Вставить("НалоговыйУчет"                  , Ложь);
	ДанныеСчета.Вставить("КоличествоСубконто"             , 0);
	
	МаксКоличествоСубконто = Метаданные.ПланыСчетов.бит_Бюджетирование.МаксКоличествоСубконто;
	
	Для ИндексСубконто = 1 По МаксКоличествоСубконто Цикл
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто,                   Неопределено);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "Наименование",  Неопределено);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТипЗначения",   Неопределено);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТолькоОбороты", Ложь);
	КонецЦикла;
	
	Если НЕ ЗначениеЗаполнено(Счет) Тогда
		Возврат ДанныеСчета;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Счет", Счет);
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Бюджетирование.Ссылка КАК Ссылка,
	|	Бюджетирование.Родитель КАК Родитель,
	|	Бюджетирование.Код КАК Код,
	|	Бюджетирование.КодБыстрогоВыбора КАК КодБыстрогоВыбора,
	|	Бюджетирование.Наименование КАК Наименование,
	|	Бюджетирование.Вид КАК Вид,
	|	Бюджетирование.Забалансовый КАК Забалансовый,
	|	Бюджетирование.ЗапретитьИспользоватьВПроводках КАК ЗапретитьИспользоватьВПроводках,
	|	Бюджетирование.Валютный КАК Валютный,
	|	Бюджетирование.Количественный КАК Количественный
	|ИЗ
	|	ПланСчетов.бит_Бюджетирование КАК Бюджетирование
	|ГДЕ
	|	Бюджетирование.Ссылка = &Счет
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	БюджетированиеВидыСубконто.НомерСтроки КАК НомерСтроки,
	|	БюджетированиеВидыСубконто.ВидСубконто КАК ВидСубконто,
	|	БюджетированиеВидыСубконто.ВидСубконто.Наименование КАК Наименование,
	|	БюджетированиеВидыСубконто.ВидСубконто.ТипЗначения КАК ТипЗначения,
	|	БюджетированиеВидыСубконто.ТолькоОбороты КАК ТолькоОбороты
	|ИЗ
	|	ПланСчетов.бит_Бюджетирование.ВидыСубконто КАК БюджетированиеВидыСубконто
	|ГДЕ
	|	БюджетированиеВидыСубконто.Ссылка = &Счет
	|
	|УПОРЯДОЧИТЬ ПО
	|	БюджетированиеВидыСубконто.НомерСтроки";
	
	МассивРезультатов	= Запрос.ВыполнитьПакет();
	
	Выборка = МассивРезультатов[0].Выбрать();
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(ДанныеСчета, Выборка);
	КонецЕсли;
		
	ВыборкаВидыСубконто	= МассивРезультатов[1].Выбрать();
		
	ДанныеСчета.КоличествоСубконто	= ВыборкаВидыСубконто.Количество();
		
	ИндексСубконто	= 0;
		
	Пока ВыборкаВидыСубконто.Следующий() Цикл
		
		ИндексСубконто	= ИндексСубконто + 1;
		
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто,                   ВыборкаВидыСубконто.ВидСубконто);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "Наименование",  ВыборкаВидыСубконто.Наименование);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТипЗначения",   ВыборкаВидыСубконто.ТипЗначения);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТолькоОбороты", ВыборкаВидыСубконто.ТолькоОбороты);
		
	КонецЦикла;
	
	Возврат Новый ФиксированнаяСтруктура(ДанныеСчета);
	
КонецФункции

Функция ПолучитьСвойстваСчетаУправленческий(Знач Счет)

	ДанныеСчета = Новый Структура;
	ДанныеСчета.Вставить("Ссылка"                         , ПланыСчетов.бит_Дополнительный_1.ПустаяСсылка());
	ДанныеСчета.Вставить("Наименование"                   , "");
	ДанныеСчета.Вставить("Код"                            , "");
	ДанныеСчета.Вставить("КодБыстрогоВыбора"              , "");
	ДанныеСчета.Вставить("Родитель"                       , ПланыСчетов.бит_Дополнительный_1.ПустаяСсылка());
	ДанныеСчета.Вставить("Вид"                            , Неопределено);
	ДанныеСчета.Вставить("Забалансовый"                   , Ложь);
	ДанныеСчета.Вставить("ЗапретитьИспользоватьВПроводках", Ложь);
	ДанныеСчета.Вставить("Валютный"                       , Ложь);
	ДанныеСчета.Вставить("Количественный"                 , Ложь);
	ДанныеСчета.Вставить("УчетПоПодразделениям"           , Ложь);
	ДанныеСчета.Вставить("НалоговыйУчет"                  , Ложь);
	ДанныеСчета.Вставить("КоличествоСубконто"             , 0);
	
	МаксКоличествоСубконто = Метаданные.ПланыСчетов.бит_Дополнительный_1.МаксКоличествоСубконто;
	
	Для ИндексСубконто = 1 По МаксКоличествоСубконто Цикл
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто,                   Неопределено);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "Наименование",  Неопределено);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТипЗначения",   Неопределено);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "Суммовой",      Ложь);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТолькоОбороты", Ложь);
	КонецЦикла;
	
	Если НЕ ЗначениеЗаполнено(Счет) Тогда
		Возврат ДанныеСчета;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Счет", Счет);
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Управленческий.Ссылка КАК Ссылка,
	|	Управленческий.Родитель КАК Родитель,
	|	Управленческий.Код КАК Код,
	|	Управленческий.КодБыстрогоВыбора КАК КодБыстрогоВыбора,
	|	Управленческий.Наименование КАК Наименование,
	|	Управленческий.Вид КАК Вид,
	|	Управленческий.Забалансовый КАК Забалансовый,
	|	Управленческий.ЗапретитьИспользоватьВПроводках КАК ЗапретитьИспользоватьВПроводках,
	|	Управленческий.Валютный КАК Валютный,
	|	Управленческий.Количественный КАК Количественный
	|ИЗ
	|	ПланСчетов.бит_Дополнительный_1 КАК Управленческий
	|ГДЕ
	|	Управленческий.Ссылка = &Счет
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	УправленческийВидыСубконто.НомерСтроки КАК НомерСтроки,
	|	УправленческийВидыСубконто.ВидСубконто КАК ВидСубконто,
	|	УправленческийВидыСубконто.ВидСубконто.Наименование КАК Наименование,
	|	УправленческийВидыСубконто.ВидСубконто.ТипЗначения КАК ТипЗначения,
	|	УправленческийВидыСубконто.ТолькоОбороты КАК ТолькоОбороты,
	|	УправленческийВидыСубконто.Суммовой КАК Суммовой
	|ИЗ
	|	ПланСчетов.бит_Дополнительный_1.ВидыСубконто КАК УправленческийВидыСубконто
	|ГДЕ
	|	УправленческийВидыСубконто.Ссылка = &Счет
	|
	|УПОРЯДОЧИТЬ ПО
	|	УправленческийВидыСубконто.НомерСтроки";
	
	МассивРезультатов	= Запрос.ВыполнитьПакет();
	
	Выборка = МассивРезультатов[0].Выбрать();
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(ДанныеСчета, Выборка);
	КонецЕсли;
		
	ВыборкаВидыСубконто	= МассивРезультатов[1].Выбрать();
		
	ДанныеСчета.КоличествоСубконто	= ВыборкаВидыСубконто.Количество();
		
	ИндексСубконто	= 0;
		
	Пока ВыборкаВидыСубконто.Следующий() Цикл
		
		ИндексСубконто	= ИндексСубконто + 1;
		
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто,                   ВыборкаВидыСубконто.ВидСубконто);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "Наименование",  ВыборкаВидыСубконто.Наименование);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТипЗначения",   ВыборкаВидыСубконто.ТипЗначения);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "Суммовой",      ВыборкаВидыСубконто.Суммовой);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТолькоОбороты", ВыборкаВидыСубконто.ТолькоОбороты);
		
	КонецЦикла;
	
	Возврат Новый ФиксированнаяСтруктура(ДанныеСчета);
	
КонецФункции

Функция ПолучитьСвойстваСчетаДополнительный2(Знач Счет)

	ДанныеСчета = Новый Структура;
	ДанныеСчета.Вставить("Ссылка"                         , ПланыСчетов.бит_Дополнительный_2.ПустаяСсылка());
	ДанныеСчета.Вставить("Наименование"                   , "");
	ДанныеСчета.Вставить("Код"                            , "");
	ДанныеСчета.Вставить("КодБыстрогоВыбора"              , "");
	ДанныеСчета.Вставить("Родитель"                       , ПланыСчетов.бит_Дополнительный_2.ПустаяСсылка());
	ДанныеСчета.Вставить("Вид"                            , Неопределено);
	ДанныеСчета.Вставить("Забалансовый"                   , Ложь);
	ДанныеСчета.Вставить("ЗапретитьИспользоватьВПроводках", Ложь);
	ДанныеСчета.Вставить("Валютный"                       , Ложь);
	ДанныеСчета.Вставить("Количественный"                 , Ложь);
	ДанныеСчета.Вставить("УчетПоПодразделениям"           , Ложь);
	ДанныеСчета.Вставить("НалоговыйУчет"                  , Ложь);
	ДанныеСчета.Вставить("КоличествоСубконто"             , 0);
	
	МаксКоличествоСубконто = Метаданные.ПланыСчетов.бит_Дополнительный_2.МаксКоличествоСубконто;
	
	Для ИндексСубконто = 1 По МаксКоличествоСубконто Цикл
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто,                   Неопределено);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "Наименование",  Неопределено);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТипЗначения",   Неопределено);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТолькоОбороты", Ложь);
	КонецЦикла;
	
	Если НЕ ЗначениеЗаполнено(Счет) Тогда
		Возврат ДанныеСчета;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Счет", Счет);
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Международный.Ссылка КАК Ссылка,
	|	Международный.Родитель КАК Родитель,
	|	Международный.Код КАК Код,
	|	Международный.КодБыстрогоВыбора КАК КодБыстрогоВыбора,
	|	Международный.Наименование КАК Наименование,
	|	Международный.Вид КАК Вид,
	|	Международный.Забалансовый КАК Забалансовый,
	|	Международный.ЗапретитьИспользоватьВПроводках КАК ЗапретитьИспользоватьВПроводках,
	|	Международный.Валютный КАК Валютный,
	|	Международный.Количественный КАК Количественный
	|ИЗ
	|	ПланСчетов.бит_Дополнительный_2 КАК Международный
	|ГДЕ
	|	Международный.Ссылка = &Счет
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	МеждународныйВидыСубконто.НомерСтроки КАК НомерСтроки,
	|	МеждународныйВидыСубконто.ВидСубконто КАК ВидСубконто,
	|	МеждународныйВидыСубконто.ВидСубконто.Наименование КАК Наименование,
	|	МеждународныйВидыСубконто.ВидСубконто.ТипЗначения КАК ТипЗначения,
	|	МеждународныйВидыСубконто.ТолькоОбороты КАК ТолькоОбороты
	|ИЗ
	|	ПланСчетов.бит_Дополнительный_2.ВидыСубконто КАК МеждународныйВидыСубконто
	|ГДЕ
	|	МеждународныйВидыСубконто.Ссылка = &Счет
	|
	|УПОРЯДОЧИТЬ ПО
	|	МеждународныйВидыСубконто.НомерСтроки";
	
	МассивРезультатов	= Запрос.ВыполнитьПакет();
	
	Выборка = МассивРезультатов[0].Выбрать();
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(ДанныеСчета, Выборка);
	КонецЕсли;
		
	ВыборкаВидыСубконто	= МассивРезультатов[1].Выбрать();
		
	ДанныеСчета.КоличествоСубконто	= ВыборкаВидыСубконто.Количество();
		
	ИндексСубконто	= 0;
		
	Пока ВыборкаВидыСубконто.Следующий() Цикл
		
		ИндексСубконто	= ИндексСубконто + 1;
		
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто,                   ВыборкаВидыСубконто.ВидСубконто);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "Наименование",  ВыборкаВидыСубконто.Наименование);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТипЗначения",   ВыборкаВидыСубконто.ТипЗначения);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТолькоОбороты", ВыборкаВидыСубконто.ТолькоОбороты);
		
	КонецЦикла;
	
	Возврат Новый ФиксированнаяСтруктура(ДанныеСчета);
	
КонецФункции

Функция ПолучитьСвойстваСчетаДополнительный3(Знач Счет)

	ДанныеСчета = Новый Структура;
	ДанныеСчета.Вставить("Ссылка"                         , ПланыСчетов.бит_Дополнительный_3.ПустаяСсылка());
	ДанныеСчета.Вставить("Наименование"                   , "");
	ДанныеСчета.Вставить("Код"                            , "");
	ДанныеСчета.Вставить("КодБыстрогоВыбора"              , "");
	ДанныеСчета.Вставить("Родитель"                       , ПланыСчетов.бит_Дополнительный_3.ПустаяСсылка());
	ДанныеСчета.Вставить("Вид"                            , Неопределено);
	ДанныеСчета.Вставить("Забалансовый"                   , Ложь);
	ДанныеСчета.Вставить("ЗапретитьИспользоватьВПроводках", Ложь);
	ДанныеСчета.Вставить("Валютный"                       , Ложь);
	ДанныеСчета.Вставить("Количественный"                 , Ложь);
	ДанныеСчета.Вставить("УчетПоПодразделениям"           , Ложь);
	ДанныеСчета.Вставить("НалоговыйУчет"                  , Ложь);
	ДанныеСчета.Вставить("КоличествоСубконто"             , 0);
	
	МаксКоличествоСубконто = Метаданные.ПланыСчетов.бит_Дополнительный_3.МаксКоличествоСубконто;
	
	Для ИндексСубконто = 1 По МаксКоличествоСубконто Цикл
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто,                   Неопределено);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "Наименование",  Неопределено);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТипЗначения",   Неопределено);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТолькоОбороты", Ложь);
	КонецЦикла;
	
	Если НЕ ЗначениеЗаполнено(Счет) Тогда
		Возврат ДанныеСчета;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Счет", Счет);
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Дополнительный.Ссылка КАК Ссылка,
	|	Дополнительный.Родитель КАК Родитель,
	|	Дополнительный.Код КАК Код,
	|	Дополнительный.КодБыстрогоВыбора КАК КодБыстрогоВыбора,
	|	Дополнительный.Наименование КАК Наименование,
	|	Дополнительный.Вид КАК Вид,
	|	Дополнительный.Забалансовый КАК Забалансовый,
	|	Дополнительный.ЗапретитьИспользоватьВПроводках КАК ЗапретитьИспользоватьВПроводках,
	|	Дополнительный.Валютный КАК Валютный,
	|	Дополнительный.Количественный КАК Количественный
	|ИЗ
	|	ПланСчетов.бит_Дополнительный_3 КАК Дополнительный
	|ГДЕ
	|	Дополнительный.Ссылка = &Счет
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДополнительныйВидыСубконто.НомерСтроки КАК НомерСтроки,
	|	ДополнительныйВидыСубконто.ВидСубконто КАК ВидСубконто,
	|	ДополнительныйВидыСубконто.ВидСубконто.Наименование КАК Наименование,
	|	ДополнительныйВидыСубконто.ВидСубконто.ТипЗначения КАК ТипЗначения,
	|	ДополнительныйВидыСубконто.ТолькоОбороты КАК ТолькоОбороты
	|ИЗ
	|	ПланСчетов.бит_Дополнительный_3.ВидыСубконто КАК ДополнительныйВидыСубконто
	|ГДЕ
	|	ДополнительныйВидыСубконто.Ссылка = &Счет
	|
	|УПОРЯДОЧИТЬ ПО
	|	ДополнительныйВидыСубконто.НомерСтроки";
	
	МассивРезультатов	= Запрос.ВыполнитьПакет();
	
	Выборка = МассивРезультатов[0].Выбрать();
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(ДанныеСчета, Выборка);
	КонецЕсли;
		
	ВыборкаВидыСубконто	= МассивРезультатов[1].Выбрать();
		
	ДанныеСчета.КоличествоСубконто	= ВыборкаВидыСубконто.Количество();
		
	ИндексСубконто	= 0;
		
	Пока ВыборкаВидыСубконто.Следующий() Цикл
		
		ИндексСубконто	= ИндексСубконто + 1;
		
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто,                   ВыборкаВидыСубконто.ВидСубконто);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "Наименование",  ВыборкаВидыСубконто.Наименование);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТипЗначения",   ВыборкаВидыСубконто.ТипЗначения);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТолькоОбороты", ВыборкаВидыСубконто.ТолькоОбороты);
		
	КонецЦикла;
	
	Возврат Новый ФиксированнаяСтруктура(ДанныеСчета);
	
КонецФункции

Функция ПолучитьСвойстваСчетаДополнительный4(Знач Счет)

	ДанныеСчета = Новый Структура;
	ДанныеСчета.Вставить("Ссылка"                         , ПланыСчетов.бит_Дополнительный_4.ПустаяСсылка());
	ДанныеСчета.Вставить("Наименование"                   , "");
	ДанныеСчета.Вставить("Код"                            , "");
	ДанныеСчета.Вставить("КодБыстрогоВыбора"              , "");
	ДанныеСчета.Вставить("Родитель"                       , ПланыСчетов.бит_Дополнительный_4.ПустаяСсылка());
	ДанныеСчета.Вставить("Вид"                            , Неопределено);
	ДанныеСчета.Вставить("Забалансовый"                   , Ложь);
	ДанныеСчета.Вставить("ЗапретитьИспользоватьВПроводках", Ложь);
	ДанныеСчета.Вставить("Валютный"                       , Ложь);
	ДанныеСчета.Вставить("Количественный"                 , Ложь);
	ДанныеСчета.Вставить("УчетПоПодразделениям"           , Ложь);
	ДанныеСчета.Вставить("НалоговыйУчет"                  , Ложь);
	ДанныеСчета.Вставить("КоличествоСубконто"             , 0);
	
	МаксКоличествоСубконто = Метаданные.ПланыСчетов.бит_Дополнительный_4.МаксКоличествоСубконто;
	
	Для ИндексСубконто = 1 По МаксКоличествоСубконто Цикл
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто,                   Неопределено);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "Наименование",  Неопределено);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТипЗначения",   Неопределено);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТолькоОбороты", Ложь);
	КонецЦикла;
	
	Если НЕ ЗначениеЗаполнено(Счет) Тогда
		Возврат ДанныеСчета;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Счет", Счет);
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Дополнительный.Ссылка КАК Ссылка,
	|	Дополнительный.Родитель КАК Родитель,
	|	Дополнительный.Код КАК Код,
	|	Дополнительный.КодБыстрогоВыбора КАК КодБыстрогоВыбора,
	|	Дополнительный.Наименование КАК Наименование,
	|	Дополнительный.Вид КАК Вид,
	|	Дополнительный.Забалансовый КАК Забалансовый,
	|	Дополнительный.ЗапретитьИспользоватьВПроводках КАК ЗапретитьИспользоватьВПроводках,
	|	Дополнительный.Валютный КАК Валютный,
	|	Дополнительный.Количественный КАК Количественный
	|ИЗ
	|	ПланСчетов.бит_Дополнительный_4 КАК Дополнительный
	|ГДЕ
	|	Дополнительный.Ссылка = &Счет
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДополнительныйВидыСубконто.НомерСтроки КАК НомерСтроки,
	|	ДополнительныйВидыСубконто.ВидСубконто КАК ВидСубконто,
	|	ДополнительныйВидыСубконто.ВидСубконто.Наименование КАК Наименование,
	|	ДополнительныйВидыСубконто.ВидСубконто.ТипЗначения КАК ТипЗначения,
	|	ДополнительныйВидыСубконто.ТолькоОбороты КАК ТолькоОбороты
	|ИЗ
	|	ПланСчетов.бит_Дополнительный_4.ВидыСубконто КАК ДополнительныйВидыСубконто
	|ГДЕ
	|	ДополнительныйВидыСубконто.Ссылка = &Счет
	|
	|УПОРЯДОЧИТЬ ПО
	|	ДополнительныйВидыСубконто.НомерСтроки";
	
	МассивРезультатов	= Запрос.ВыполнитьПакет();
	
	Выборка = МассивРезультатов[0].Выбрать();
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(ДанныеСчета, Выборка);
	КонецЕсли;
		
	ВыборкаВидыСубконто	= МассивРезультатов[1].Выбрать();
		
	ДанныеСчета.КоличествоСубконто	= ВыборкаВидыСубконто.Количество();
		
	ИндексСубконто	= 0;
		
	Пока ВыборкаВидыСубконто.Следующий() Цикл
		
		ИндексСубконто	= ИндексСубконто + 1;
		
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто,                   ВыборкаВидыСубконто.ВидСубконто);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "Наименование",  ВыборкаВидыСубконто.Наименование);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТипЗначения",   ВыборкаВидыСубконто.ТипЗначения);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТолькоОбороты", ВыборкаВидыСубконто.ТолькоОбороты);
		
	КонецЦикла;
	
	Возврат Новый ФиксированнаяСтруктура(ДанныеСчета);	
КонецФункции

Функция ПолучитьСвойстваСчетаДополнительный5(Знач Счет)

	ДанныеСчета = Новый Структура;
	ДанныеСчета.Вставить("Ссылка"                         , ПланыСчетов.бит_Дополнительный_5.ПустаяСсылка());
	ДанныеСчета.Вставить("Наименование"                   , "");
	ДанныеСчета.Вставить("Код"                            , "");
	ДанныеСчета.Вставить("КодБыстрогоВыбора"              , "");
	ДанныеСчета.Вставить("Родитель"                       , ПланыСчетов.бит_Дополнительный_5.ПустаяСсылка());
	ДанныеСчета.Вставить("Вид"                            , Неопределено);
	ДанныеСчета.Вставить("Забалансовый"                   , Ложь);
	ДанныеСчета.Вставить("ЗапретитьИспользоватьВПроводках", Ложь);
	ДанныеСчета.Вставить("Валютный"                       , Ложь);
	ДанныеСчета.Вставить("Количественный"                 , Ложь);
	ДанныеСчета.Вставить("УчетПоПодразделениям"           , Ложь);
	ДанныеСчета.Вставить("НалоговыйУчет"                  , Ложь);
	ДанныеСчета.Вставить("КоличествоСубконто"             , 0);
	
	МаксКоличествоСубконто = Метаданные.ПланыСчетов.бит_Дополнительный_5.МаксКоличествоСубконто;
	
	Для ИндексСубконто = 1 По МаксКоличествоСубконто Цикл
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто,                   Неопределено);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "Наименование",  Неопределено);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТипЗначения",   Неопределено);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТолькоОбороты", Ложь);
	КонецЦикла;
	
	Если НЕ ЗначениеЗаполнено(Счет) Тогда
		Возврат ДанныеСчета;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Счет", Счет);
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Дополнительный.Ссылка КАК Ссылка,
	|	Дополнительный.Родитель КАК Родитель,
	|	Дополнительный.Код КАК Код,
	|	Дополнительный.КодБыстрогоВыбора КАК КодБыстрогоВыбора,
	|	Дополнительный.Наименование КАК Наименование,
	|	Дополнительный.Вид КАК Вид,
	|	Дополнительный.Забалансовый КАК Забалансовый,
	|	Дополнительный.ЗапретитьИспользоватьВПроводках КАК ЗапретитьИспользоватьВПроводках,
	|	Дополнительный.Валютный КАК Валютный,
	|	Дополнительный.Количественный КАК Количественный
	|ИЗ
	|	ПланСчетов.бит_Дополнительный_5 КАК Дополнительный
	|ГДЕ
	|	Дополнительный.Ссылка = &Счет
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДополнительныйВидыСубконто.НомерСтроки КАК НомерСтроки,
	|	ДополнительныйВидыСубконто.ВидСубконто КАК ВидСубконто,
	|	ДополнительныйВидыСубконто.ВидСубконто.Наименование КАК Наименование,
	|	ДополнительныйВидыСубконто.ВидСубконто.ТипЗначения КАК ТипЗначения,
	|	ДополнительныйВидыСубконто.ТолькоОбороты КАК ТолькоОбороты
	|ИЗ
	|	ПланСчетов.бит_Дополнительный_5.ВидыСубконто КАК ДополнительныйВидыСубконто
	|ГДЕ
	|	ДополнительныйВидыСубконто.Ссылка = &Счет
	|
	|УПОРЯДОЧИТЬ ПО
	|	ДополнительныйВидыСубконто.НомерСтроки";
	
	МассивРезультатов	= Запрос.ВыполнитьПакет();
	
	Выборка = МассивРезультатов[0].Выбрать();
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(ДанныеСчета, Выборка);
	КонецЕсли;
		
	ВыборкаВидыСубконто	= МассивРезультатов[1].Выбрать();
		
	ДанныеСчета.КоличествоСубконто	= ВыборкаВидыСубконто.Количество();
		
	ИндексСубконто	= 0;
		
	Пока ВыборкаВидыСубконто.Следующий() Цикл
		
		ИндексСубконто	= ИндексСубконто + 1;
		
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто,                   ВыборкаВидыСубконто.ВидСубконто);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "Наименование",  ВыборкаВидыСубконто.Наименование);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТипЗначения",   ВыборкаВидыСубконто.ТипЗначения);
		ДанныеСчета.Вставить("ВидСубконто" + ИндексСубконто + "ТолькоОбороты", ВыборкаВидыСубконто.ТолькоОбороты);
		
	КонецЦикла;
	
	Возврат Новый ФиксированнаяСтруктура(ДанныеСчета);
	
КонецФункции

Функция ПолучитьСвойстваСчетаМеждународный(Знач Счет)

	// ++ БП 
	Возврат ДанныеСчетаПоУмолчанию();
	// -- БП 
	
КонецФункции

#КонецОбласти

Функция ЕстьТиповойПланСчетовМеждународный()
	
	// ++ БП 
    Возврат Ложь;
	// -- БП 
	
КонецФункции

#КонецОбласти

