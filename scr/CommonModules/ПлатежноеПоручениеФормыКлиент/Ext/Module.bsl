﻿
#Область ОповещенияПриЗаписи

Процедура ОповеститьОЗаписиПлатежногоПорученияНаУплатуНалога(Объект, ДокументОплачен) Экспорт
	
	ПараметрыНалога = Новый Структура;
	ПараметрыНалога.Вставить("Организация",       Объект.Организация);
	ПараметрыНалога.Вставить("Налог",             Объект.Налог);
	ПараметрыНалога.Вставить("ДокументОснование", Объект.ДокументОснование);
	ПараметрыНалога.Вставить("ПоказательПериода", Объект.ПоказательПериода);
	ПараметрыНалога.Вставить("КБК",               Объект.КодБК);
	ПараметрыНалога.Вставить("ОКАТО",             Объект.КодОКАТО);
	ПараметрыНалога.Вставить("Ссылка",            Объект.Ссылка);
	ПараметрыНалога.Вставить("Оплачено",          ДокументОплачен);
	ПараметрыНалога.Вставить("Сумма",             Объект.СуммаДокумента);
	Оповестить("Запись_ПлатежныйДокумент_УплатаНалогов", ПараметрыНалога);
	
КонецПроцедуры

Процедура ОповеститьОЗаписиПлатежногоПорученияНаВыплатуЗарплатыРаботнику(Объект, ДокументОплачен) Экспорт
	
	ПараметрыЗарплаты = Новый Структура;
	ПараметрыЗарплаты.Вставить("Организация",       Объект.Организация);
	ПараметрыЗарплаты.Вставить("Ссылка",            Объект.Ссылка);
	ПараметрыЗарплаты.Вставить("Ведомость",         Объект.ПлатежнаяВедомость);
	ПараметрыЗарплаты.Вставить("Оплачено",          ДокументОплачен);
	Оповестить("Запись_ПлатежныйДокумент_ВыплатаЗарплаты", ПараметрыЗарплаты);
	
КонецПроцедуры

Процедура ОповеститьОЗаписиПлатежногоПорученияНаВыплатуЗарплаты(Объект, ДокументОплачен) Экспорт
	
	ПараметрыЗарплаты = Новый Структура;
	ПараметрыЗарплаты.Вставить("Организация", Объект.Организация);
	ПараметрыЗарплаты.Вставить("Ссылка",            Объект.Ссылка);
	ПараметрыЗарплаты.Вставить("Ведомость",         Объект.ДокументОснование);
	ПараметрыЗарплаты.Вставить("Оплачено",          ДокументОплачен);
	Оповестить("Запись_ПлатежныйДокумент_ВыплатаЗарплаты", ПараметрыЗарплаты);
	
КонецПроцедуры

#КонецОбласти

#Область ОшибкиПлатежейВБюджет

Функция ТекстВопросаОбОшибкахЗаполнения(РезультатПроверки, СообщатьОДубляхУИН) Экспорт
	
	ТекстВопроса = "";
	Если РезультатПроверки.ПредупредитьОбОшибках Тогда
		
		ТекстВопроса = НСтр("ru = 'При проверке правильности заполнения реквизитов обнаружены ошибки.
			|Записать с ошибками?'");
		
	ИначеЕсли РезультатПроверки.ПредупредитьДублиУИН И СообщатьОДубляхУИН Тогда
		
		ШаблонТекстаВопроса = НСтр("ru = '%1
			|
			|Записать документ?'");
		
		ТекстВопроса = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			ШаблонТекстаВопроса,
			РезультатПроверки.ИнформацияДублиУИН);
		
	ИначеЕсли РезультатПроверки.ПредупредитьУИНСодержитБуквы Тогда
		
		ШаблонТекстаВопроса = НСтр("ru = '%1
			|
			|Записать документ?'");
		
		ТекстВопроса = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			ШаблонТекстаВопроса,
			РезультатПроверки.ИнформацияУИНСодержитБуквы);
		
	КонецЕсли;
	
	Возврат ТекстВопроса;
	
КонецФункции

Процедура УведомитьПользователяПлатежиВБюджет(Форма, ОписаниеОповещенияПослеИсправления) Экспорт
	
	Если ЕстьОшибкиЗаполненияПлатежаВБюджет(Форма) Тогда
		
		ИсправитьОшибкиПлатежаВБюджет(Форма, ОписаниеОповещенияПослеИсправления);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ИсправитьОшибкиПлатежаВБюджет(Форма, ОписаниеОповещенияПослеИсправления)
	
	ТекстВопроса = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = 'С %1 применяются новые правила заполнения платежных поручений в бюджет.
			|
			|Это платежное поручение не соответствует новым правилам.
			|
			|Исправить реквизиты платежа в бюджет сейчас?'"),
		Формат(ПлатежиВБюджетКлиентСервер.НачалоДействияПриказа107н(), "ДЛФ=DD"));
		
	Кнопки = Новый СписокЗначений;
	Кнопки.Добавить(КодВозвратаДиалога.Да,         НСтр("ru = 'Да, исправить сейчас'"));
	Кнопки.Добавить(КодВозвратаДиалога.Нет,        НСтр("ru = 'Нет, исправить позже'"));
	Кнопки.Добавить(КодВозвратаДиалога.Пропустить, НСтр("ru = 'Показать ошибки'"));
	
	ПараметрыОповещения = Новый Структура();
	ПараметрыОповещения.Вставить("АдресОшибок", Форма.АдресОшибок);
	ПараметрыОповещения.Вставить("Форма",       Форма);
	ПараметрыОповещения.Вставить("ОписаниеОповещенияПослеИсправления", ОписаниеОповещенияПослеИсправления);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ВопросИсправитьОшибкиПлатежаВБюджетЗавершение", ЭтотОбъект, ПараметрыОповещения);
	
	Форма.АдресОшибок = ""; // Очищаем значение реквизита формы. До следующего вызова НайтиОшибкиПлатежаВБюджет не используем реквизит формы.
	
	ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, Кнопки,, Кнопки[0].Значение);
	
КонецПроцедуры

Процедура ВопросИсправитьОшибкиПлатежаВБюджетЗавершение(РезультатВопроса, Параметры) Экспорт
	
	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		// Исправить прямо сейчас
		ОткрытьФормуРедактированияРеквизитовПлатежаВБюджет(
			Параметры.Форма, Параметры.ОписаниеОповещенияПослеИсправления, Истина);
	ИначеЕсли РезультатВопроса = КодВозвратаДиалога.Пропустить Тогда
		// Показать ошибки
		ОткрытьФормуРедактированияРеквизитовПлатежаВБюджет(
			Параметры.Форма, Параметры.ОписаниеОповещенияПослеИсправления, Ложь, Параметры.АдресОшибок);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОткрытьФормуРедактированияРеквизитовПлатежаВБюджет(Форма, ОписаниеОповещения, ИсправитьОшибки = Ложь, АдресОшибок = "") Экспорт
	
	Объект = Форма.Объект;
	
	РеквизитыПлатежаВБюджет = ПлатежиВБюджетКлиентСервер.НовыйРеквизитыПлатежаВБюджет();
	
	// Заполним показатели
	Для каждого ОписаниеРеквизита Из ПлатежиВБюджетКлиентСерверПереопределяемый.РеквизитыДокумента_ПлатежноеПоручение() Цикл
		РеквизитыПлатежаВБюджет[ОписаниеРеквизита.Ключ] = Объект[ОписаниеРеквизита.Значение];
	КонецЦикла;
	
	// Заполним контекст
	СвойстваКонтекста = Новый Структура;
	СвойстваКонтекста.Вставить("Период",                     Объект.Дата);
	СвойстваКонтекста.Вставить("Организация",                Объект.Организация);
	СвойстваКонтекста.Вставить("Налогоплательщик",           Объект.Налогоплательщик);
	СвойстваКонтекста.Вставить("СчетПолучателя",             Объект.СчетКонтрагента);
	СвойстваКонтекста.Вставить("Налог",                      Объект.Налог);
	СвойстваКонтекста.Вставить("ВидНалоговогоОбязательства", Объект.ВидНалоговогоОбязательства);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Реквизиты",                РеквизитыПлатежаВБюджет);
	ПараметрыФормы.Вставить("СвойстваКонтекста",        СвойстваКонтекста);
	ПараметрыФормы.Вставить("ТолькоПросмотр",           Форма.ТолькоПросмотр);
	ПараметрыФормы.Вставить("ИсправитьОшибки",          ИсправитьОшибки);
	ПараметрыФормы.Вставить("АдресИнформацииОбОшибках", АдресОшибок);
	ПараметрыФормы.Вставить("Ссылка",                   Объект.Ссылка);
	ПараметрыФормы.Вставить("ПеречислениеВБюджет",      Объект.ПеречислениеВБюджет);
	ПараметрыФормы.Вставить("УплатаНалога",
		Объект.ВидОперации = ПредопределенноеЗначение("Перечисление.ВидыОперацийСписаниеДенежныхСредств.ПеречислениеНалога")
		ИЛИ Объект.ВидОперации = ПредопределенноеЗначение("Перечисление.ВидыОперацийСписаниеДенежныхСредств.ПеречислениеНалогаЗаТретьихЛиц"));
	ПараметрыФормы.Вставить("СчетПоГосконтракту",       Форма.СчетПоГосконтракту);
	
	ОткрытьФорму(
		"ОбщаяФорма.РеквизитыПлатежаВБюджет",
		ПараметрыФормы,
		Форма,
		,
		,
		,
		ОписаниеОповещения);
	
КонецПроцедуры

Функция ЕстьОшибкиЗаполненияПлатежаВБюджет(Форма)
	
	Возврат ЗначениеЗаполнено(Форма.АдресОшибок);
	
КонецФункции

#КонецОбласти

#Область НазначениеПлатежа

Процедура ЗаполнитьРеквизитыПлатежаВБюджетПослеРедактированияВФорме(Форма, Результат) Экспорт
	
	Объект = Форма.Объект;
	
	РеквизитыДокумента = ПлатежиВБюджетКлиентСерверПереопределяемый.РеквизитыДокумента_ПлатежноеПоручение();
	
	// Если налоговый платеж по гособоронзаказу, то вместо УИН используется УИП
	Если Форма.СчетПоГосконтракту Тогда
		РеквизитыДокумента.Удалить("ИдентификаторПлатежа");
		РеквизитыДокумента.Вставить("ИдентификаторКонтракта", "ИдентификаторПлатежа");
	КонецЕсли;
	
	Для каждого РеквизитПлатежаВБюджет Из Результат Цикл
		ИмяРеквизита         = РеквизитыДокумента[РеквизитПлатежаВБюджет.Ключ];
		Если ИмяРеквизита <> Неопределено И РеквизитПлатежаВБюджет.Значение <> Неопределено Тогда
			Объект[ИмяРеквизита] = РеквизитПлатежаВБюджет.Значение;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область РедактированиеРеквизитовПлатежа

Процедура ОткрытьФормуРедактированияРеквизитовПлательщика(Форма) Экспорт
	
	Объект = Форма.Объект;
	
	ОчиститьСообщения();
	ЕстьОшибки = Ложь;
	
	Если НЕ ЗначениеЗаполнено(Объект.Организация) Тогда
		ТекстСообщения = ОбщегоНазначенияКлиентСервер.ТекстОшибкиЗаполнения(
			"Поле", "Заполнение", НСтр("ru = 'Организация'"));
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,, "Организация", "Объект", ЕстьОшибки);
	ИначеЕсли НЕ ЗначениеЗаполнено(Объект.СчетОрганизации) Тогда
		Если Форма.ИспользоватьНесколькоБанковскихСчетовОрганизации Тогда
			ТекстСообщения = ОбщегоНазначенияКлиентСервер.ТекстОшибкиЗаполнения(
			"Поле", "Заполнение", НСтр("ru = 'Банковский счет'"));
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,, "СчетОрганизации", "Объект", ЕстьОшибки);
		Иначе
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Реквизиты банковского счета не заполнены'"), ,"РеквизитыОрганизацииСсылка", ,ЕстьОшибки);
		КонецЕсли;
	КонецЕсли;
	
	Если ЕстьОшибки Тогда
		Возврат;
	КонецЕсли;
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("ЭтоПлательщик",  Истина);
	СтруктураПараметров.Вставить("ТолькоПросмотр", Форма.ТолькоПросмотр);
	СтруктураПараметров.Вставить("Объект",         Объект);
	
	ОткрытьФорму("Документ.ПлатежноеПоручение.Форма.РеквизитыПлательщикаПолучателя", СтруктураПараметров, Форма);
	
КонецПроцедуры

Процедура ОткрытьФормуРедактированияРеквизитовПолучателя(Форма) Экспорт
	
	Объект = Форма.Объект;
	
	ОчиститьСообщения();
	ЕстьОшибки = Ложь;
	
	Если Объект.ВидОперации = ПредопределенноеЗначение("Перечисление.ВидыОперацийСписаниеДенежныхСредств.ПереводНаДругойСчет") Тогда
		Если НЕ ЗначениеЗаполнено(Объект.Организация) Тогда
			ТекстСообщения = ОбщегоНазначенияКлиентСервер.ТекстОшибкиЗаполнения(
				"Поле", "Заполнение", НСтр("ru = 'Организация'"));
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,, "Организация", "Объект", ЕстьОшибки);
		КонецЕсли;
	ИначеЕсли НЕ ЗначениеЗаполнено(Объект.Контрагент) Тогда
		ТекстСообщения = ОбщегоНазначенияКлиентСервер.ТекстОшибкиЗаполнения(
			"Поле", "Заполнение", НСтр("ru = 'Получатель'"));
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,, "Контрагент", "Объект", ЕстьОшибки);
	ИначеЕсли НЕ ЗначениеЗаполнено(Объект.СчетКонтрагента) Тогда
		ТекстСообщения = ОбщегоНазначенияКлиентСервер.ТекстОшибкиЗаполнения(
			"Поле", "Заполнение", НСтр("ru = 'Счет получателя'"));
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,, "СчетКонтрагента", "Объект", ЕстьОшибки);
	КонецЕсли;
	
	Если ЕстьОшибки Тогда
		Возврат;
	КонецЕсли;
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("ЭтоПлательщик",  Ложь);
	СтруктураПараметров.Вставить("ТолькоПросмотр", Форма.ТолькоПросмотр);
	СтруктураПараметров.Вставить("Объект",         Объект);
	
	ОткрытьФорму("Документ.ПлатежноеПоручение.Форма.РеквизитыПлательщикаПолучателя", СтруктураПараметров, Форма);
	
КонецПроцедуры

Процедура ОткрытьФормуРедактированияРеквизитовНаУплатуНалога(Форма, ОповещениеПриЗавершенииРедактирования) Экспорт
	
	Объект = Форма.Объект;
	
	ОчиститьСообщения();
	ЕстьОшибки = Ложь;
	
	Если НЕ ЗначениеЗаполнено(Объект.Организация) Тогда
		ТекстСообщения = ОбщегоНазначенияКлиентСервер.ТекстОшибкиЗаполнения(
			"Поле", "Заполнение", НСтр("ru = 'Организация'"));
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,, "Организация", "Объект", ЕстьОшибки);
	КонецЕсли;
	
	Если ЕстьОшибки Тогда
		Возврат;
	КонецЕсли;
	
	ПлатежноеПоручениеФормыКлиент.ОткрытьФормуРедактированияРеквизитовПлатежаВБюджет(
		Форма, ОповещениеПриЗавершенииРедактирования);
	
КонецПроцедуры

#КонецОбласти

