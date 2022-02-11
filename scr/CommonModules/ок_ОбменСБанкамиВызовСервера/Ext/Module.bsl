﻿//ОК(СофтЛаб) Вдовиченко Г.В. 20190901 (#3436)

#Область ПрограммныйИнтерфейс

Функция ОставитьТолькоНевыгруженныеВБанкДокументы(МассивСсылок) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ПлатежноеПоручение.Ссылка КАК Ссылка
		|ИЗ
		|	Документ.ПлатежноеПоручение КАК ПлатежноеПоручение
		|ГДЕ
		|	ПлатежноеПоручение.Ссылка В(&МассивСсылок)
		|	И НЕ ПлатежноеПоручение.СБ_ВыгруженВКлиентБанка";
	
	Запрос.УстановитьПараметр("МассивСсылок", МассивСсылок);
	
	Возврат Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	
КонецФункции

//+
//Функция ЕстьПоддержкаВидаЭД(Знач НастройкаОбмена, Знач ВидЭД, ТребуетсяПодпись = Ложь)
Функция ЕстьПоддержкаВидаЭД(Ссылка, Знач ВидЭД, ТребуетсяПодпись = Ложь, НастройкаОбмена = Неопределено) Экспорт
//+

	УстановитьПривилегированныйРежим(Истина);
	
	НастройкаОбмена = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "НастройкаОбмена");
	
	Возврат ОбменСБанкамиСлужебныйВызовСервера.ЕстьПоддержкаВидаЭД(НастройкаОбмена, ВидЭД, ТребуетсяПодпись);

КонецФункции

//+
//Процедура СформироватьЗапросСостоянияЭД(Знач НастройкаОбмена, Знач СообщениеОбменаПлатежныйДокумент, Знач ТребуетсяПодпись, ЗапросСостоянияЭД, Знач МассивОтпечатковСертификатов = Неопределено, МассивСертификатов = Неопределено) Экспорт
Процедура СформироватьЗапросСостоянияЭД(Знач НастройкаОбмена, Знач СообщениеОбменаПлатежныйДокумент, Знач ТребуетсяПодпись, ЗапросСостоянияЭД, 
			Знач МассивОтпечатковСертификатов = Неопределено, МассивСертификатов = Неопределено, 
				ИмяКомпьютера = "", ПредставлениеИПрисоединенныйФайл = Неопределено) Экспорт
//+

	УстановитьПривилегированныйРежим(Истина);
	
	Если ТребуетсяПодпись Тогда
		// Определение сертификатов подписи
		Запрос = Новый Запрос;
		Запрос.Текст =
		"ВЫБРАТЬ 
		|	ВЫБОР
		|		КОГДА Сертификаты.СертификатЭП.Пользователь = &Пользователь
		|			ТОГДА 0
		|		ИНАЧЕ 1
		|	КОНЕЦ КАК Порядок,
		|	Сертификаты.СертификатЭП КАК Сертификат,
		|	Сертификаты.СертификатЭП.Отпечаток КАК Отпечаток
		|ИЗ
		|	Справочник.НастройкиОбменСБанками.СертификатыПодписейОрганизации КАК Сертификаты
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПодписываемыеВидыЭД КАК ВидыЭД
		|		ПО (ВидыЭД.СертификатЭП = Сертификаты.СертификатЭП)
		|ГДЕ
		|	НЕ Сертификаты.СертификатЭП.ПометкаУдаления
		|	И НЕ Сертификаты.СертификатЭП.Отозван
		|	И ВидыЭД.ВидЭД = &ВидЭД
		|	И &ПроверкаПользователя
		|	И ВидыЭД.Использовать
		|	И Сертификаты.Ссылка = &НастройкаОбмена
		|
		|УПОРЯДОЧИТЬ ПО
		|	Порядок";
		
		Запрос.УстановитьПараметр("ВидЭД", Перечисления.ВидыЭДОбменСБанками.ЗапросОСостоянииЭД);
		Запрос.УстановитьПараметр("НастройкаОбмена", НастройкаОбмена);
		
		//+
		//у нас будет схема, ключ сертификата может быть установлен у нескольких бухгалтеров, поэтому отключим фильтр
		//Если Пользователи.ЭтоПолноправныйПользователь( , , Ложь) Тогда
		//+
			Запрос.Текст = СтрЗаменить(Запрос.Текст, "&ПроверкаПользователя", "ИСТИНА");
		//+
		//Иначе
		//	Запрос.УстановитьПараметр("ПользовательНеУказан", Пользователи.СсылкаНеуказанногоПользователя());
		//	Запрос.УстановитьПараметр("Пользователь",  Пользователи.АвторизованныйПользователь());
		//	Запрос.Текст = СтрЗаменить(Запрос.Текст, "&ПроверкаПользователя",
		//		"Сертификаты.СертификатЭП.Пользователь В (&Пользователь, ЗНАЧЕНИЕ(Справочник.Пользователи.ПустаяСсылка), &ПользовательНеУказан)");
		//КонецЕсли;
		//+
		
		Запрос.УстановитьПараметр("Пользователь",  Пользователи.АвторизованныйПользователь());
			
		ТаблицаСертификатов = Запрос.Выполнить().Выгрузить();
		
		Если ТаблицаСертификатов.Количество() = 0 Тогда
			ТекстСообщения = НСтр("ru = 'Не найден подходящий сертификат подписи для документа Запрос состояния электронного документа.
										|Проверьте настройки обмена через сервис 1С:ДиректБанк.'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
			Возврат;
		КонецЕсли;
		
		ПрограммаБанка = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(НастройкаОбмена, "ПрограммаБанка");
		
		МассивСертификатов = Новый Массив;
		Если ПрограммаБанка = Перечисления.ПрограммыБанка.ОбменЧерезВК Тогда 
			Для Каждого Строка Из ТаблицаСертификатов Цикл
				МассивСертификатов.Добавить(Строка.Сертификат);
			КонецЦикла;
		ИначеЕсли МассивОтпечатковСертификатов <> Неопределено Тогда
			
			//++
			ОбменСБанкамиСлужебный.ДобавитьОтпечаткиСертификатовНаСервере(МассивОтпечатковСертификатов);
			//++
			
			Для Каждого Строка Из ТаблицаСертификатов Цикл
				Если МассивОтпечатковСертификатов.Найти(Строка.Отпечаток) <> Неопределено Тогда
					МассивСертификатов.Добавить(Строка.Сертификат);
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
		
		//+
		МассивСертификатов = РегистрыСведений.ок_РасположениеКлючейЭлектроннойПодписи.ОставитьТолькоСертификатыСДоступнымиКлючами(МассивСертификатов, ИмяКомпьютера, Истина);
		//+
		
		Если МассивСертификатов.Количество() = 0 Тогда
			ТекстСообщения = НСтр("ru = 'На компьютере не установлен ни один сертификат, указанный в настройке обмена.
										|Установите сертификаты или обратитесь к администратору.'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	// Формирование электронного документа
	ТекстОшибки = "";
	ВерсияПрограммы = ОбменСБанкамиСлужебныйПовтИсп.ВерсияПрограммыКлиентаДляБанка();
	РеквизитыНастройкиОбмена = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(
		НастройкаОбмена, "Организация, ИдентификаторОрганизации, Банк, Недействительна, ВерсияФормата");
	Если РеквизитыНастройкиОбмена.Недействительна Тогда
		ШаблонСообщения = НСтр("ru = 'Настройка обмена с банком %1 недействительна'");
		ТекстСообщения = СтрШаблон(ШаблонСообщения, НастройкаОбмена);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
		Возврат;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(РеквизитыНастройкиОбмена.ВерсияФормата) Тогда
		ВерсияФормата = РеквизитыНастройкиОбмена.ВерсияФормата;
	Иначе
		ВерсияФормата = ОбменСБанкамиКлиентСервер.АктуальнаяВерсияФорматаАсинхронногоОбмена();
	КонецЕсли;
	
	ПространствоИмен = ОбменСБанкамиСлужебный.ПространствоИменАсинхронногоОбмена(ВерсияФормата);

	
	Фабрика = ОбменСБанкамиСлужебныйПовтИсп.ФабрикаAsyncXDTO(ВерсияФормата);
	
	ИдентификаторОрганизации = РеквизитыНастройкиОбмена.ИдентификаторОрганизации;
	
	ОтправительНаименование = ЭлектронноеВзаимодействиеСлужебный.СокращенноеНаименованиеОрганизации(
		РеквизитыНастройкиОбмена.Организация);
	РеквизитыОрганизации = Неопределено;
	ЭлектронноеВзаимодействиеПереопределяемый.ПолучитьДанныеЮрФизЛица(
		РеквизитыНастройкиОбмена.Организация, РеквизитыОрганизации);
	РеквизитыБанка = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(РеквизитыНастройкиОбмена.Банк, "Код, Наименование");
	
	ИдентификаторПлатежа = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(СообщениеОбменаПлатежныйДокумент, "Идентификатор");
	Попытка
		
		УникальныйИдЭД = Новый УникальныйИдентификатор;

		ЗапросОСостоянииЭД = ОбменСБанкамиСлужебный.ОбъектТипаCML(Фабрика, "StatusRequest", ПространствоИмен);
		ОбменСБанкамиСлужебный.ЗаполнитьСвойствоXDTO(ЗапросОСостоянииЭД, "id", Строка(УникальныйИдЭД), Истина, ТекстОшибки);
		ОбменСБанкамиСлужебный.ЗаполнитьСвойствоXDTO(ЗапросОСостоянииЭД, "ExtID", ИдентификаторПлатежа, Истина, ТекстОшибки);
		ОбменСБанкамиСлужебный.ЗаполнитьСвойствоXDTO(ЗапросОСостоянииЭД, "formatVersion", ВерсияФормата, Истина, ТекстОшибки);
		ОбменСБанкамиСлужебный.ЗаполнитьСвойствоXDTO(
			ЗапросОСостоянииЭД, "creationDate", ТекущаяДатаСеанса(), Истина, ТекстОшибки);
		ОбменСБанкамиСлужебный.ЗаполнитьСвойствоXDTO(ЗапросОСостоянииЭД, "userAgent", ВерсияПрограммы, , ТекстОшибки);
		Отправитель = ОбменСБанкамиСлужебный.ОбъектТипаCML(Фабрика, "CustomerPartyType", ПространствоИмен);
		ОбменСБанкамиСлужебный.ЗаполнитьСвойствоXDTO(
			Отправитель, "id", РеквизитыНастройкиОбмена.ИдентификаторОрганизации, Истина, ТекстОшибки);
		ОбменСБанкамиСлужебный.ЗаполнитьСвойствоXDTO(Отправитель, "name", ОтправительНаименование, Истина, ТекстОшибки);
		ОбменСБанкамиСлужебный.ЗаполнитьСвойствоXDTO(Отправитель, "inn", РеквизитыОрганизации.ИНН, Истина, ТекстОшибки);
		ОбменСБанкамиСлужебный.ЗаполнитьСвойствоXDTO(Отправитель, "kpp", РеквизитыОрганизации.КПП, , ТекстОшибки);
		ОбменСБанкамиСлужебный.ЗаполнитьСвойствоXDTO(ЗапросОСостоянииЭД, "Sender", Отправитель, Истина, ТекстОшибки);
		
		Получатель = ОбменСБанкамиСлужебный.ОбъектТипаCML(Фабрика, "BankPartyType", ПространствоИмен);
		ОбменСБанкамиСлужебный.ЗаполнитьСвойствоXDTO(Получатель, "bic", РеквизитыБанка.Код, Истина, ТекстОшибки);
		ОбменСБанкамиСлужебный.ЗаполнитьСвойствоXDTO(Получатель, "name", РеквизитыБанка.Наименование, Истина, ТекстОшибки);
		ОбменСБанкамиСлужебный.ЗаполнитьСвойствоXDTO(ЗапросОСостоянииЭД, "Recipient", Получатель, Истина, ТекстОшибки);
		ЗапросОСостоянииЭД.Проверить();
		
		Если ЗначениеЗаполнено(ТекстОшибки) Тогда
			ТекстСообщения = ТекстОшибки;
			Операция = НСтр("ru = 'Формирование электронного документа'");
			ЭлектронноеВзаимодействиеСлужебныйВызовСервера.ОбработатьОшибку(
				Операция, ТекстОшибки, ТекстСообщения, "ОбменСБанками", СообщениеОбменаПлатежныйДокумент);
			Возврат;
		КонецЕсли;
		
		ДвоичныеДанные = ОбменСБанкамиСлужебный.ДвоичныеДанныеИзXDTO(Фабрика, ЗапросОСостоянииЭД, Ложь);
		
	Исключение
		ТекстСообщения = КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
		Операция = НСтр("ru = 'Формирование электронного документа'");
		ПодробноеПредставлениеОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЭлектронноеВзаимодействиеСлужебныйВызовСервера.ОбработатьОшибку(
			Операция, ПодробноеПредставлениеОшибки, ТекстСообщения, "ОбменСБанками", СообщениеОбменаПлатежныйДокумент);
		Возврат;
	КонецПопытки;
	
	
	АдресФайла = ПоместитьВоВременноеХранилище(ДвоичныеДанные);
	
	//++
	//НазваниеЭД = НСтр("ru = 'Запрос состояния электронного документа'");
	//++
	
	Реквизиты = Новый Структура;
	//++
	//Реквизиты.Вставить("ПредставлениеДокумента", НазваниеЭД);
	//++
	Реквизиты.Вставить("Расширение", "xml");
	Реквизиты.Вставить("АдресФайлаВоВременномХранилище", АдресФайла);
	Реквизиты.Вставить("Идентификатор", Строка(УникальныйИдЭД));
	Реквизиты.Вставить("Направление", Перечисления.НаправленияЭД.Исходящий);
	Реквизиты.Вставить("ВидЭД", Перечисления.ВидыЭДОбменСБанками.ЗапросОСостоянииЭД);
	Реквизиты.Вставить("Статус", Перечисления.СтатусыОбменСБанками.Сформирован);
	Реквизиты.Вставить("Организация", РеквизитыНастройкиОбмена.Организация);
	Реквизиты.Вставить("Банк", РеквизитыНастройкиОбмена.Банк);
	Реквизиты.Вставить("СообщениеРодитель", СообщениеОбменаПлатежныйДокумент);
	Реквизиты.Вставить("НастройкаОбмена", НастройкаОбмена);
	
	ОбменСБанкамиСлужебный.СохранитьСообщениеОбмена(Реквизиты, ЗапросСостоянияЭД);
	
	//++
	//перенесли все в другие модули, усложнили оптимизацию, поэтому отключаю
	
	////+
	////оптимизация типового кода, чтобы лишний раз не бегать на сервер
	//Если ЗапросСостоянияЭД = Неопределено Тогда
	//	Возврат;
	//КонецЕсли;
	//
	//ПредставлениеИПрисоединенныйФайл = ПредставлениеИПрисоединенныйФайл(ЗапросСостоянияЭД);
	////+
	
	//++
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

//++
//Функция ПредставлениеИПрисоединенныйФайл(СообщениеОбмена)
//	
//	СтруктураВозврата = Новый Структура;
//	СтруктураВозврата.Вставить("Представление", Строка(СообщениеОбмена));
//	ПрисоединенныйФайл = ОбменСБанкамиСлужебныйВызовСервера.ПрисоединенныйФайл(СообщениеОбмена);
//	СтруктураВозврата.Вставить("ПрисоединенныйФайл", ПрисоединенныйФайл);
//	Возврат СтруктураВозврата;
//	
//КонецФункции
//++

#КонецОбласти
