
#Область СлужебныйПрограммныйИнтерфейс

// Процедура проведения документов "Уведомление об остатках прослеживаемых товаров" и "Уведомление о ввозе прослеживаемых товаров"
// 
// Параметры:
//  ПараметрыПроведения - Структура таблиц см. Документы.УведомлениеОбОстаткахПрослеживаемыхТоваров.ПодготовитьПараметрыПроведения
//                        и Документы.УведомлениеОВвозеПрослеживаемыхТоваров.ПодготовитьПараметрыПроведения
//  Движения - ссылка на движения документа
//  Отказ - Булево - признак отказа от записи
Процедура ОбработкаПроведенияУведомление(ПараметрыПроведения, Движения, Отказ) Экспорт
	
	ПрослеживаемостьПереопределяемый.ОбработкаПроведенияУведомление(ПараметрыПроведения, Движения, Отказ)
	
КонецПроцедуры

// Процедура удаления проведения документа "Уведомление об остатках прослеживаемых товаров" и "Уведомление о ввозе прослеживаемых товаров"
// 
// Параметры:
// Регистратор - ДокументСсылка - Документ регистратор
// Основание - ДокументСсылка - Первичный документ
// 
Процедура ОбработкаУдаленияПроведенияУведомление(Регистратор, Основание) Экспорт
	
	ПрослеживаемостьПереопределяемый.ОбработкаУдаленияПроведенияУведомление(Регистратор, Основание);
	
КонецПроцедуры

// Возвращает признак применения Федерального Закона от 09.11.2020 № 371-ФЗ
// который вводит понятие прослеживаемости для определенных групп товаров
// Параметры
// Дата - тип дата, в данном параметре передается
//        дата на которую необходимо определить признак применения ФЗ
// Возвращаемое значение:
//  Булево - признак применения
//           Истина - ФЗ применяется
//           Ложь   - ФЗ не применяется
Функция ВедетсяУчетПрослеживаемыхТоваров(Дата) Экспорт
	
	НачалоПримененияФЗ = ДатаНачалаУчетаПрослеживаемыхТоваров();
	
	Если Дата < НачалоПримененияФЗ Тогда
		Возврат Ложь;
	Иначе
		Возврат Истина;
	КонецЕсли;
	
КонецФункции

// Процедура проведения документа Уведомления о перемещении прослеживаемых товаров
// 
// Параметры:
//  ПараметрыПроведения - Структура таблиц см. Документы.УведомлениеОПеремещенииПрослеживаемыхТоваров.ПодготовитьПараметрыПроведения
//  Движения - ссылка на движения документа
//  Отказ - Булево - признак отказа от записи
Процедура ОбработкаПроведенияУведомлениеОПеремещении(ПараметрыПроведения, Движения, Отказ) Экспорт

	ТаблицаРеализацииТоваров = ПодготовитьТаблицуПрослеживаемыеТоварыОтгрузкаВЕАЭС(ПараметрыПроведения.ТаблицаТоваров,
		ПараметрыПроведения.Реквизиты, Отказ);
	
	СформироватьДвиженияПрослеживаемыеТоварыОтгруженныевЕАЭС(
		ТаблицаРеализацииТоваров,
		Движения,
		Отказ);
	
	ПрослеживаемостьПереопределяемый.ОбработкаПроведенияУведомлениеОПеремещении(ПараметрыПроведения, Движения, Отказ)
	
КонецПроцедуры

// См. УправлениеПечатьюПереопределяемый.ПриОпределенииОбъектовСКомандамиПечати.
Процедура ПриОпределенииОбъектовСКомандамиПечати(СписокОбъектов) Экспорт
	
	СписокОбъектов.Добавить(Документы.УведомлениеОбОстаткахПрослеживаемыхТоваров);
	СписокОбъектов.Добавить(Документы.УведомлениеОВвозеПрослеживаемыхТоваров);
	
КонецПроцедуры

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа
Процедура ПриЗаполненииСписковСОграничениемДоступа(Списки) Экспорт

	Списки.Вставить(Метаданные.Документы.УведомлениеОбОстаткахПрослеживаемыхТоваров, Истина);
	Списки.Вставить(Метаданные.Документы.УведомлениеОВвозеПрослеживаемыхТоваров, Истина);
	Списки.Вставить(Метаданные.Документы.УведомлениеОПеремещенииПрослеживаемыхТоваров, Истина);
	Списки.Вставить(Метаданные.ЖурналыДокументов.ПрослеживаемостьУведомления, Истина);
	
	ПрослеживаемостьПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа(Списки);
	
КонецПроцедуры

// Дата, до которой в программе можно формировать Уведомление об остатках прослеживаемого товара
// и получать РНПТ
Функция ДатаОкончанияРегистрацииУведомленийОбОСтатках() Экспорт
	
	Возврат '20211231235959';
	
КонецФункции

// См. описание процедуры ПрослеживаемостьПереопределяемый.ОбработкаЗаполненияУведомленияОПеремещении
//
Процедура ЗаполнитьУведомлениеОПеремещенииПрослеживаемыхТоваров(УведомлениеОбъект, ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка) Экспорт
	
	УведомлениеОбъект.Ответственный = Пользователи.ТекущийПользователь();
	
	Если Не ЗначениеЗаполнено(ДанныеЗаполнения) Тогда
		Возврат;
	КонецЕсли;
	
	Если ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ДанныеЗаполнения, "Проведен") = Ложь Тогда
		
		ТекстОшибки = НСтр("ru='Документ %Документ% не проведен. Ввод на основании непроведенного документа запрещен.'");
		ТекстОшибки = СтрЗаменить(ТекстОшибки, "%Документ%", ДанныеЗаполнения);
		ВызватьИсключение ТекстОшибки;
		
	КонецЕсли;
	
	ЗаполнитьЗначенияСвойств(УведомлениеОбъект, ДанныеЗаполнения, "Организация");
	
	Если УведомлениеОбъект.Дата < ДанныеЗаполнения.Дата Тогда
		
		УведомлениеОбъект.Дата = ДанныеЗаполнения.Дата + 1;
		
	КонецЕсли;
	
	ДанныеТаблиц = Документы.УведомлениеОПеремещенииПрослеживаемыхТоваров.ЗаполнитьДокументДанными(
		УведомлениеОбъект.Дата, УведомлениеОбъект.Организация, ДанныеЗаполнения);
	
	УведомлениеОбъект.Контрагенты.Загрузить(ДанныеТаблиц.Контрагенты);
	УведомлениеОбъект.Товары.Загрузить(ДанныеТаблиц.Товары);
		
КонецПроцедуры

// Возвращает виды уведомлений
// 
// Возвращаемое значение:
// Структура - Виды уведомлений
Функция ВидыУведомлений() Экспорт

	Возврат Новый Структура("Уведомление, КорректировочноеУведомление", "Уведомление", "КорректировочноеУведомление");

КонецФункции

// Устанавливает заголовок формы документа Уведомление об остатках прослеживаемых товаров
//
// Параметры:
// Форма - ФормаКлиентскогоПриложения - ссылка на форму
//
Функция УстановитьЗаголовокФормыУведомлениеОбОстатках(Форма) Экспорт
	
	Объект = Форма.Объект;
	НомерКорректировки = Объект.НомерКорректировки;

	Если НомерКорректировки > 0 Тогда
		
		ТекстЗаголовка = НСтр("ru = 'Корректировочное уведомление'");
		
	Иначе
		
		ТекстЗаголовка = НСтр("ru = 'Уведомление'");
		
	КонецЕсли;
	
	ТекстЗаголовка = ТекстЗаголовка + НСтр("ru = ' об остатках прослеживаемых товаров'");
	
	Если ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ТекстЗаголовка = ТекстЗаголовка + СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru=' %1 от %2'"), Объект.Номер, Объект.Дата);
	Иначе
		ТекстЗаголовка = ТекстЗаголовка + НСтр("ru = ' (создание)'");
	КонецЕсли;
	
	Форма.Заголовок = ТекстЗаголовка;
	
КонецФункции

// Возвращает дату начала учета прослеживаемых товаров // указать номер закона
//
// Возвращаемы параметры:
// Дата - дата начала учета 
//
Функция ДатаНачалаУчетаПрослеживаемыхТоваров() Экспорт
	
	Возврат '20210701000000';
	
КонецФункции

// Процедура проверяет что по указанному номеру корректировки не было других корректировочных уведомлений
//
// Параметры:
// УведомлениеОбъект - ДокументОбъект.УведомлениеОбОстаткахПрослеживаемыхТоваров
//                               - документ Уведомление об остатках прослеживаемых товаров
//
Процедура ПроверитьДублированиеНомераКорректировкиВУведомлениях(УведомлениеОбъект) Экспорт
	
	НомерКорректировки = УведомлениеОбъект.НомерКорректировки;
	
	Если НомерКорректировки = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Организация", УведомлениеОбъект.Организация);
	Запрос.УстановитьПараметр("ДокументУведомлениеОбОстатках", УведомлениеОбъект.ДокументУведомлениеОбОстатках);
	Запрос.УстановитьПараметр("НомерКорректировки", НомерКорректировки);
	Запрос.УстановитьПараметр("ДокументИсключение", УведомлениеОбъект.Ссылка);
	Запрос.Текст =
	"ВЫБРАТЬ
	|	УведомлениеОбОстаткахПрослеживаемыхТоваров.Ссылка КАК Ссылка
	|ИЗ
	|	Документ.УведомлениеОбОстаткахПрослеживаемыхТоваров КАК УведомлениеОбОстаткахПрослеживаемыхТоваров
	|ГДЕ
	|	УведомлениеОбОстаткахПрослеживаемыхТоваров.ПометкаУдаления = ЛОЖЬ
	|	И УведомлениеОбОстаткахПрослеживаемыхТоваров.ДокументУведомлениеОбОстатках = &ДокументУведомлениеОбОстатках
	|	И УведомлениеОбОстаткахПрослеживаемыхТоваров.Организация = &Организация
	|	И УведомлениеОбОстаткахПрослеживаемыхТоваров.Ссылка <> &ДокументИсключение
	|	И УведомлениеОбОстаткахПрослеживаемыхТоваров.НомерКорректировки = &НомерКорректировки";
	
	Результат = Запрос.Выполнить();
	
	Если Не Результат.Пустой() Тогда
		
		ТекстИсключения = НСтр("ru = 'Корректировка №%НомерКорректировки% первичного уведомления об остатках прослеживаемых товаров уже существует'");
		ТекстИсключения = СтрЗаменить(ТекстИсключения, "%НомерКорректировки%", НомерКорректировки);
		
		ВызватьИсключение(ТекстИсключения);
		
	КонецЕсли;
	
КонецПроцедуры

// Заполняет список кодов формы реорганизации 
//
// Параметры:
// СписокКодовФомы - СписокЗначений - Список, который нужно заполнить
//
Процедура СписокКодовФормыРеорганизации(СписокКодовФормы) Экспорт
	
	ЗначенияФормРеорганизации = СписокОписанийКодовФормыРеорганизации();
	
	СписокКодовФормы.Добавить("", ЗначенияФормРеорганизации.Отсутствует);
	СписокКодовФормы.Добавить("0", ЗначенияФормРеорганизации.Ликвидация);
	СписокКодовФормы.Добавить("1", ЗначенияФормРеорганизации.Преобразование);
	СписокКодовФормы.Добавить("2", ЗначенияФормРеорганизации.Слияние);
	СписокКодовФормы.Добавить("3", ЗначенияФормРеорганизации.Разделение);
	СписокКодовФормы.Добавить("5", ЗначенияФормРеорганизации.Присоединение);
	СписокКодовФормы.Добавить("6", ЗначенияФормРеорганизации.РазделениеИПрисоединение);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПодготовитьТаблицуПрослеживаемыеТоварыОтгрузкаВЕАЭС(ТаблицаТоваров, ТаблицаРеквизитов, Отказ)
	
	Если Не ЗначениеЗаполнено(ТаблицаТоваров)
	 Или Не ЗначениеЗаполнено(ТаблицаРеквизитов) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Параметры = ПодготовитьПараметрыТаблицыРеализацияПрослеживаемыхТоваров(ТаблицаТоваров, ТаблицаРеквизитов);
	Реквизиты = Параметры.Реквизиты[0];
	
	ТаблицаПрослеживаемыхТоваров = ПодготовитьТаблицуПрослеживаемыеТоварыОтгруженныевЕАЭС(Реквизиты, Параметры.ТаблицаТоваров, Отказ);
	
	Возврат ТаблицаПрослеживаемыхТоваров;
	
КонецФункции

Процедура СформироватьДвиженияПрослеживаемыеТоварыОтгруженныевЕАЭС(ТаблицаТоваров, Движения, Отказ)
	
	Если НЕ ЗначениеЗаполнено(ТаблицаТоваров) Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого СтрокаТаблицы Из ТаблицаТоваров Цикл
		Запись = Движения.ПрослеживаемыеТоварыОтгруженныеВЕАЭС.Добавить();
		ЗаполнитьЗначенияСвойств(Запись, СтрокаТаблицы);
		Запись.ВидДвижения = ВидДвиженияНакопления.Расход;
	КонецЦикла;
	
	Движения.ПрослеживаемыеТоварыОтгруженныеВЕАЭС.Записывать = Истина;
	
КонецПроцедуры

Функция ПодготовитьПараметрыТаблицыРеализацияПрослеживаемыхТоваров(ТаблицаТоваров, ТаблицаРеквизитов)

	Параметры = Новый Структура;
	
	// Подготовка таблицы Параметры.ТаблицаТоваров
	
	СписокОбязательныхКолонок = ""
		+ "РНПТ,"                       // <СправочникСсылка.*> - РНПТ
		+ "Номенклатура,"               // <СправочникСсылка.*> - списываемая номенклатура
		+ "НомерСтроки,"                // <Число> - номер строки в списке 
		+ "Количество,"                 // <Число> - количество по первичным документам
		+ "КоличествоПрослеживаемости," // <Число> - количество прослеживаемости
		+ "Сумма,"						// <Число> - сумма
		+ "ПорядковыйНомер,"            // <Число> - номер строки номеклатуры в сопроводительном документе
		+ "Контрагент,"                 // <СправочникСсылка.Контрагенты> - количество по первичным документам
		+ "СопроводительныйДокумент,";  // <ОпределяемыйТип.СопроводительныйДокументУведомлениеОПеремещении> - документ отгрузки
		
	Параметры.Вставить("ТаблицаТоваров", ОбщегоНазначенияБПВызовСервера.ПолучитьТаблицуПараметровПроведения(
		ТаблицаТоваров, СписокОбязательныхКолонок));
		
	// Подготовка таблицы Параметры.Реквизиты
	
	СписокОбязательныхКолонок = ""
		+ "Период,"				// <Дата> - период движений - дата документа
		+ "Регистратор,"		// <ДокументСсылка.*> - документ-регистратор движений
		+ "Организация";		// <СправочникСсылка.Организации>
		
	Параметры.Вставить("Реквизиты", ОбщегоНазначенияБПВызовСервера.ПолучитьТаблицуПараметровПроведения(
		ТаблицаРеквизитов, СписокОбязательныхКолонок));
		
	Возврат Параметры;

КонецФункции

Функция ПодготовитьТаблицуПрослеживаемыеТоварыОтгруженныевЕАЭС(Реквизиты, ТаблицаТоваров, Отказ)

	ТаблицаПрослеживаемогоТовара = ТаблицаТоваров.Скопировать();
	ТаблицаПрослеживаемогоТовара.Колонки.Добавить("Период", Новый ОписаниеТипов("Дата"));
	ТаблицаПрослеживаемогоТовара.Колонки.Добавить("Организация", Новый ОписаниеТипов("СправочникСсылка.Организации"));
	
	ТаблицаПрослеживаемогоТовара.ЗаполнитьЗначения(Реквизиты.Период, "Период");
	ТаблицаПрослеживаемогоТовара.ЗаполнитьЗначения(Реквизиты.Организация, "Организация");
	
	ПроверитьОстаткиТовара(Реквизиты, ТаблицаТоваров, Отказ);
	
	Возврат ТаблицаПрослеживаемогоТовара;
	
КонецФункции

Процедура ВывестиСообщениеОбОшибках(ТаблицаОшибок, Регистратор, Отказ)
	
	Для каждого Ошибка Из ТаблицаОшибок Цикл
		
		ТекстОшибки = НСтр("ru='По контрагенту %1, указанное количество превышает количество по сопроводительному документу. Количество: %2; Не хватает: %3'");
		
		ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстОшибки,
			Ошибка.Контрагент,
			Ошибка.Количество,
			Ошибка.КоличествоОсталосьПогасить);
		
		ТекстСообщения = ОбщегоНазначенияКлиентСервер.ТекстОшибкиЗаполнения(
			"Колонка", 
			"Корректность",
			НСтр("ru = 'Количество'"),
			Ошибка.НомерСтроки,
			"Товары",
			ТекстОшибки);
			
		ПолеКоличество = "Товары" + "[" + Формат(Ошибка.НомерСтроки - 1, "ЧН=0; ЧГ=") + "].Количество";
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, Регистратор, ПолеКоличество, "Объект", Отказ);
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ПроверитьОстаткиТовара(Реквизиты, ТаблицаТоваров, Отказ)
	
	Запрос = Новый Запрос;
	
	// Блокируем регистр ПрослеживаемыеТоварыОтгруженныеВЕАЭС для получения остатков
	Блокировка = Новый БлокировкаДанных;
	ЭлементБлокировки = Блокировка.Добавить("РегистрНакопления.ПрослеживаемыеТоварыОтгруженныеВЕАЭС");
	ЭлементБлокировки.УстановитьЗначение("Организация", Реквизиты.Организация);
	ЭлементБлокировки.УстановитьЗначение("Период", Новый Диапазон(, Реквизиты.Период));
	ЭлементБлокировки.ИсточникДанных = ТаблицаТоваров;
	ЭлементБлокировки.ИспользоватьИзИсточникаДанных("Номенклатура", "Номенклатура");
	ЭлементБлокировки.ИспользоватьИзИсточникаДанных("Контрагент", "Контрагент");
	ЭлементБлокировки.ИспользоватьИзИсточникаДанных("СопроводительныйДокумент", "СопроводительныйДокумент");
	ЭлементБлокировки.ИспользоватьИзИсточникаДанных("РНПТ", "РНПТ");
	Блокировка.Заблокировать();
	
	Запрос.УстановитьПараметр("ТаблицаТоваров", ТаблицаТоваров);
	Запрос.УстановитьПараметр("Организация", Реквизиты.Организация);
	
	МоментВремени = Новый Граница(Новый МоментВремени(Реквизиты.Период, Реквизиты.Регистратор), ВидГраницы.Исключая);
	Запрос.УстановитьПараметр("МоментВремени", МоментВремени);
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ТаблицаТоваров.НомерСтроки КАК НомерСтроки,
	|	ТаблицаТоваров.Номенклатура КАК Номенклатура,
	|	ТаблицаТоваров.Количество КАК Количество,
	|	ТаблицаТоваров.РНПТ КАК РНПТ,
	|	ТаблицаТоваров.ПорядковыйНомер КАК ПорядковыйНомер,
	|	ТаблицаТоваров.Контрагент КАК Контрагент,
	|	ТаблицаТоваров.СопроводительныйДокумент КАК СопроводительныйДокумент
	|ПОМЕСТИТЬ ТаблицаТоваров
	|ИЗ
	|	&ТаблицаТоваров КАК ТаблицаТоваров
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПрослеживаемыеТоварыОтгруженныеВЕАЭСОстатки.Организация КАК Организация,
	|	ПрослеживаемыеТоварыОтгруженныеВЕАЭСОстатки.Контрагент КАК Контрагент,
	|	ПрослеживаемыеТоварыОтгруженныеВЕАЭСОстатки.СопроводительныйДокумент КАК СопроводительныйДокумент,
	|	ПрослеживаемыеТоварыОтгруженныеВЕАЭСОстатки.Номенклатура КАК Номенклатура,
	|	ПрослеживаемыеТоварыОтгруженныеВЕАЭСОстатки.РНПТ КАК РНПТ,
	|	ПрослеживаемыеТоварыОтгруженныеВЕАЭСОстатки.ПорядковыйНомер КАК ПорядковыйНомер,
	|	ПрослеживаемыеТоварыОтгруженныеВЕАЭСОстатки.КоличествоОстаток КАК КоличествоОстаток,
	|	ПрослеживаемыеТоварыОтгруженныеВЕАЭСОстатки.КоличествоПрослеживаемостиОстаток КАК КоличествоПрослеживаемостиОстаток,
	|	ПрослеживаемыеТоварыОтгруженныеВЕАЭСОстатки.СуммаОстаток КАК СуммаОстаток,
	|	ТаблицаТоваров.Количество КАК Количество,
	|	ТаблицаТоваров.Количество - ПрослеживаемыеТоварыОтгруженныеВЕАЭСОстатки.КоличествоОстаток КАК КоличествоОсталосьПогасить,
	|	ТаблицаТоваров.НомерСтроки КАК НомерСтроки
	|ИЗ
	|	ТаблицаТоваров КАК ТаблицаТоваров
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.ПрослеживаемыеТоварыОтгруженныеВЕАЭС.Остатки(&МоментВремени, Организация = &Организация) КАК ПрослеживаемыеТоварыОтгруженныеВЕАЭСОстатки
	|		ПО ТаблицаТоваров.Номенклатура = ПрослеживаемыеТоварыОтгруженныеВЕАЭСОстатки.Номенклатура
	|			И ТаблицаТоваров.РНПТ = ПрослеживаемыеТоварыОтгруженныеВЕАЭСОстатки.РНПТ
	|			И ТаблицаТоваров.ПорядковыйНомер = ПрослеживаемыеТоварыОтгруженныеВЕАЭСОстатки.ПорядковыйНомер
	|			И ТаблицаТоваров.СопроводительныйДокумент = ПрослеживаемыеТоварыОтгруженныеВЕАЭСОстатки.СопроводительныйДокумент
	|ГДЕ
	|	ПрослеживаемыеТоварыОтгруженныеВЕАЭСОстатки.КоличествоОстаток - ТаблицаТоваров.Количество < 0";
	
	Результат = Запрос.Выполнить().Выбрать();
	
	ТаблицаОшибок = ТаблицаТоваров.СкопироватьКолонки("Контрагент, НомерСтроки, Количество");
	ТаблицаОшибок.Колонки.Добавить("КоличествоОсталосьПогасить", Новый ОписаниеТипов("Число"));
	
	Пока Результат.Следующий() Цикл
		
		СтрокаТаблицыОшибок = ТаблицаОшибок.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаТаблицыОшибок, Результат);
		СтрокаТаблицыОшибок.КоличествоОсталосьПогасить = Результат.КоличествоОсталосьПогасить;
		
	КонецЦикла;
	
	ВывестиСообщениеОбОшибках(ТаблицаОшибок, Реквизиты.Регистратор, Отказ)
	
КонецПроцедуры

Функция СписокОписанийКодовФормыРеорганизации()
	
	Возврат Новый Структура("Отсутствует,Ликвидация,Преобразование,Слияние,Разделение,Присоединение,РазделениеИПрисоединение",
						"Отсутствует","0- Ликвидация","1- Преобразование","2- Слияние","3 - Разделение","5 - Присоединение",
						"6 - Разделение с одновременным присоединением");
	
КонецФункции

// Функция возвращает правильный признак уведомления в документе Уведомление об остатках
// 1 и 2
// 
// Параметры:
// ПризнакУведомления - Число - признак уведомения (0,1,2,3)
// 
// Возвращаемое значение:
// Строка - правильный признак
Функция ПолучитьПризнакУведомления(ПризнакУведомления) Экспорт
	
	Если ПризнакУведомления > 1 Тогда
		Возврат ПризнакУведомления - 1;
	КонецЕсли;
		
	Возврат ПризнакУведомления;
	
КонецФункции

// Процедура сохраняет в журнале отчетов статусы информацию о документе
//
// Параметры:
// Форма - ФормаКлиентскогоПриложения - ссылка на форму
//
Процедура СохранитьСтатусОтправки(Форма) Экспорт
	Объект = Форма.Объект;
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("СсылкаНаОбъект", Объект.Ссылка);
	СтруктураПараметров.Вставить("Форма", Форма);
	
	ИнтерфейсыВзаимодействияБРО.СохранитьСтатусОтправки(СтруктураПараметров);
	
КонецПроцедуры

#КонецОбласти
