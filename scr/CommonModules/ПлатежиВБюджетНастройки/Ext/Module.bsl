﻿
#Область ПрограммныйИнтерфейс

Процедура СоздатьИзменитьНастройкуПлатежаВБюджет(РеквизитыОбъекта, Настройки, РеквизитыВБюджетПоУмолчанию) Экспорт
	
	МенеджерЗаписи = РегистрыСведений.РеквизитыУплатыНалоговИПлатежейВБюджет.СоздатьМенеджерЗаписи();
	ЗаполнитьЗначенияСвойств(МенеджерЗаписи, Настройки.КлючНастройкиЗаполнения);
	МенеджерЗаписи.Прочитать();
	
	Если НЕ МенеджерЗаписи.Выбран() Тогда
		ЗаполнитьЗначенияСвойств(МенеджерЗаписи, Настройки.КлючНастройкиЗаполнения);
	КонецЕсли;
	
	Если Настройки.ИзмененныеНастройки.СтатусСоставителя Тогда
		МенеджерЗаписи.СтатусСоставителя  = РеквизитыОбъекта.СтатусСоставителя;
	ИначеЕсли НЕ ЗначениеЗаполнено(МенеджерЗаписи.СтатусСоставителя) Тогда
		МенеджерЗаписи.СтатусСоставителя  = РеквизитыВБюджетПоУмолчанию.СтатусСоставителя;
	КонецЕсли;
	
	Если РеквизитыВБюджетПоУмолчанию.Свойство("ОчередностьПлатежа") Тогда
		МенеджерЗаписи.ОчередностьПлатежа = РеквизитыВБюджетПоУмолчанию.ОчередностьПлатежа;
	Иначе
		МенеджерЗаписи.ОчередностьПлатежа = УчетДенежныхСредствКлиентСервер.ОчередностьПлатежаНалогиВзносы();
	КонецЕсли;
	
	МенеджерЗаписи.ВидПеречисленияВБюджет = Настройки.КлючНастройкиЗаполнения.ВидПеречисленияВБюджет;
	
	Если Настройки.ИзмененныеНастройки.СтатьяДвиженияДенежныхСредств Тогда
		МенеджерЗаписи.СтатьяДвиженияДенежныхСредств = РеквизитыОбъекта.СтатьяДвиженияДенежныхСредств;
	КонецЕсли;
	
	Если Настройки.ИзмененныеНастройки.ПоказательПериода Тогда
		Если Настройки.КлючНастройкиЗаполнения.ВидПеречисленияВБюджет = Перечисления.ВидыПеречисленийВБюджет.ТаможенныйПлатеж Тогда
			МенеджерЗаписи.ПоказательПериода = РеквизитыОбъекта.ПоказательПериода;
		Иначе
			ПериодичностьПлатежаВБюджет = ПлатежиВБюджетКлиентСервер.РазобратьНалоговыйПериод(РеквизитыОбъекта.ПоказательПериода);
			МенеджерЗаписи.ПоказательПериода = ПериодичностьПлатежаВБюджет.Периодичность;
		КонецЕсли;
	Иначе
		ПериодичностьПлатежаВБюджет = ПлатежиВБюджетКлиентСервер.РазобратьНалоговыйПериод(РеквизитыВБюджетПоУмолчанию.ПоказательПериода);
		МенеджерЗаписи.ПоказательПериода = ПериодичностьПлатежаВБюджет.Периодичность;
	КонецЕсли;
	
	Если Настройки.ИзмененныеНастройки.РеквизитыПолучателя.ОчиститьНастройкиПолучателя Тогда
		МенеджерЗаписи.Получатель     = Справочники.Контрагенты.ПустаяСсылка();
		МенеджерЗаписи.СчетПолучателя = Справочники.БанковскиеСчета.ПустаяСсылка();
	ИначеЕсли Настройки.ИзмененныеНастройки.РеквизитыПолучателя.Получатель
		ИЛИ Настройки.ИзмененныеНастройки.РеквизитыПолучателя.СчетПолучателя Тогда
		МенеджерЗаписи.Получатель     = РеквизитыОбъекта.Контрагент;
		МенеджерЗаписи.СчетПолучателя = РеквизитыОбъекта.СчетКонтрагента;
	КонецЕсли;
	
	Если Настройки.ИзмененныеНастройки.КодТерритории Тогда
		ПравилаЗаполнения = ПлатежиВБюджетНастройки.ПравилаЗаполненияРеквизитовПлатежа(МенеджерЗаписи.ВидПлатежа);
		Если ПравилаЗаполнения.СохранятьКодТерриторииПриЗаписи Тогда
			МенеджерЗаписи.КодТерритории = РеквизитыОбъекта.КодТерритории;
		КонецЕсли;
	КонецЕсли;
	
	Попытка
		МенеджерЗаписи.Записать();
	Исключение
		// фиксация исключения не требуется
	КонецПопытки;
	
КонецПроцедуры

Функция РеквизитыПлатежногоДокумента() Экспорт
	
	РеквизитыОбъекта = Новый Структура;
	РеквизитыОбъекта.Вставить("Дата");
	РеквизитыОбъекта.Вставить("Организация");
	РеквизитыОбъекта.Вставить("Налог");
	РеквизитыОбъекта.Вставить("ВидОперации");
	РеквизитыОбъекта.Вставить("ВидПеречисленияВБюджет");
	РеквизитыОбъекта.Вставить("Контрагент");
	РеквизитыОбъекта.Вставить("СчетКонтрагента");
	РеквизитыОбъекта.Вставить("СтатьяДвиженияДенежныхСредств");
	РеквизитыОбъекта.Вставить("СтатусСоставителя");
	РеквизитыОбъекта.Вставить("ПоказательПериода");
	РеквизитыОбъекта.Вставить("КодТерритории");
	
	Возврат РеквизитыОбъекта;
	
КонецФункции

Функция ПроверитьНастройкуПлатежаВБюджет(РеквизитыОбъекта, РеквизитыВБюджетПоУмолчанию, РегистрацияВНалоговомОргане) Экспорт
	
	// Для того чтобы понять, нужно ли нам создать/изменить настройку, требуется получить:
	//  - значения из настройки, если она есть и значение в ней заполнено;
	//  - значения "по умолчанию", если настройки нет, или значение в ней не заполнено.
	
	ПоддерживаемыйНалог     = ЗначениеЗаполнено(РеквизитыОбъекта.Налог.ВидНалога);
	
	НастройкаЗаполнения     = Неопределено;
	КлючНастройкиЗаполнения = РегистрыСведений.РеквизитыУплатыНалоговИПлатежейВБюджет.КлючНастройкиУплатыНалога(
		РеквизитыОбъекта.Налог, РеквизитыОбъекта.Организация, РегистрацияВНалоговомОргане);
	Если КлючНастройкиЗаполнения <> Неопределено Тогда
		Если РеквизитыОбъекта.Свойство("ПоказателиПериода") Тогда
			НастройкаЗаполнения = РегистрыСведений.РеквизитыУплатыНалоговИПлатежейВБюджет.ДанныеЗаполнения(
				КлючНастройкиЗаполнения,
				РеквизитыОбъекта.ПоказателиПериода.Период,
				РеквизитыОбъекта.Организация,
				,
				РеквизитыОбъекта.ПоказателиПериода
			);
		Иначе
			НастройкаЗаполнения = РегистрыСведений.РеквизитыУплатыНалоговИПлатежейВБюджет.ДанныеЗаполнения(
				КлючНастройкиЗаполнения,
				РеквизитыОбъекта.Дата,
				РеквизитыОбъекта.Организация
			);
		КонецЕсли;
	КонецЕсли;
	
	ПравилаЗаполнения = ПлатежиВБюджетНастройки.ПравилаЗаполненияРеквизитовПлатежа(РеквизитыОбъекта.Налог);
	
	ИзмененныеНастройки     = ОтслеживаемыеНастройки();
	Для каждого КлючИЗначение Из ИзмененныеНастройки Цикл
		Если КлючИЗначение.Ключ = "СтатусСоставителя" Тогда
			ИзмененныеНастройки.Вставить(КлючИЗначение.Ключ, ПроверитьСтатусСоставителя(
				РеквизитыОбъекта, НастройкаЗаполнения, РеквизитыВБюджетПоУмолчанию, ПоддерживаемыйНалог));
		ИначеЕсли КлючИЗначение.Ключ = "ПоказательПериода" Тогда
			ИзмененныеНастройки.Вставить(КлючИЗначение.Ключ, ПроверитьПоказательПериода(
				РеквизитыОбъекта, НастройкаЗаполнения, РеквизитыВБюджетПоУмолчанию, ПоддерживаемыйНалог));
		ИначеЕсли КлючИЗначение.Ключ = "СтатьяДвиженияДенежныхСредств" Тогда
			ИзмененныеНастройки.Вставить(КлючИЗначение.Ключ, ПроверитьСтатьяДДС(РеквизитыОбъекта, НастройкаЗаполнения));
		ИначеЕсли КлючИЗначение.Ключ = "РеквизитыПолучателя" Тогда
			ИзмененныеНастройки.Вставить(КлючИЗначение.Ключ,
				ПроверитьРеквизитыПолучателя(РеквизитыОбъекта, НастройкаЗаполнения, РеквизитыВБюджетПоУмолчанию, КлючИЗначение.Значение));
		ИначеЕсли КлючИЗначение.Ключ = "КодТерритории" Тогда
			ИзмененныеНастройки.Вставить(КлючИЗначение.Ключ, ПроверитьКодТерритории(
				РеквизитыОбъекта, НастройкаЗаполнения, РеквизитыВБюджетПоУмолчанию, ПравилаЗаполнения));
		КонецЕсли;
	КонецЦикла;
	
	Настройки = Новый Структура;
	Настройки.Вставить("КлючНастройкиЗаполнения",
		Новый Структура("ВидПлатежа, Организация, РегистрацияВНалоговомОргане, ВидПеречисленияВБюджет",
			РеквизитыОбъекта.Налог, РеквизитыОбъекта.Организация, РегистрацияВНалоговомОргане, РеквизитыОбъекта.ВидПеречисленияВБюджет));
	
	Если НЕ НалоговыйУчет.УчетВРазрезеНалоговыхОрганов()
		ИЛИ Справочники.РегистрацииВНалоговомОргане.ПолучитьКоличествоПодчиненныхЭлементовПоВладельцу(РеквизитыОбъекта.Организация) = 1 Тогда
		Настройки.КлючНастройкиЗаполнения.РегистрацияВНалоговомОргане = Справочники.РегистрацииВНалоговомОргане.ПустаяСсылка();
	КонецЕсли;
	
	Настройки.Вставить("ИзмененныеНастройки", ИзмененныеНастройки);
	
	Возврат Настройки;
	
КонецФункции

Функция НастройкиИзменились(ИзмененныеНастройки) Экспорт
	
	Для каждого КлючИЗначение Из ИзмененныеНастройки Цикл
		Если ТипЗнч(КлючИЗначение.Значение) = Тип("Структура") Тогда
			Если НастройкиИзменились(КлючИЗначение.Значение) Тогда
				Возврат Истина;
			КонецЕсли;
		Иначе
			Если КлючИЗначение.Значение Тогда
				Возврат Истина;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

// Возвращает правила заполнения реквизитов платежа для налога.
//
// Параметры:
//  Налог	 - СправочникСсылка.ВидыНалоговИПлатежейВБюджет - Налог, для которого нужно определить правила.
// 
// Возвращаемое значение:
//   - Структура - Правила заполнения. См. НовыйПравилаЗаполненияРеквизитовПлатежа()
//
Функция ПравилаЗаполненияРеквизитовПлатежа(Налог) Экспорт
	
	Правила = НовыйПравилаЗаполненияРеквизитовПлатежа();
	
	Если Не ЗначениеЗаполнено(Налог) Тогда
		Возврат Правила;
	КонецЕсли;
	
	ВидНалога = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Налог, "ВидНалога");
	
	Если ВидНалога = Перечисления.ВидыНалогов.НалогНаПрофессиональныйДоход Тогда
		// Для налога на профессиональный доход получать налоговый орган не требуется.
		// Оплата выполняется не по месту нахождения ИП, а в тот налоговый орган, который указан в уведомлении об уплате налога.
		// Поэтому пользователь указывает налоговую самостоятельно.
		Правила.ЗаполнятьПолучателя = Ложь;
		
		// Для налога на профессиональный доход ОКТМО указывается не по месту регистрации ИП,
		// а ОКТМО региона, в котором ИП зарегистрирован как самозанятый.
		// Поэтому пользователь указывает ОКТМО самостоятельно.
		Правила.ЗаполнятьКодТерриторииПоРегистрации = Ложь;
		Правила.СохранятьКодТерриторииПриЗаписи = Истина;
		
	КонецЕсли;
	
	Возврат Правила;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция РеквизитыПолучателя()
	
	Реквизиты = Новый Структура;
	Реквизиты.Вставить("Получатель",                  Ложь);
	Реквизиты.Вставить("СчетПолучателя",              Ложь);
	Реквизиты.Вставить("ОчиститьНастройкиПолучателя", Ложь);
	
	Возврат Реквизиты;
	
КонецФункции

Функция ОтслеживаемыеНастройки()
	
	Реквизиты = Новый Структура;
	Реквизиты.Вставить("СтатусСоставителя",             Ложь);
	Реквизиты.Вставить("ПоказательПериода",             Ложь);
	Реквизиты.Вставить("СтатьяДвиженияДенежныхСредств", Ложь);
	Реквизиты.Вставить("РеквизитыПолучателя",           РеквизитыПолучателя());
	Реквизиты.Вставить("КодТерритории",                 Ложь);
	
	Возврат Реквизиты;
	
КонецФункции

Функция ПроверитьСтатьяДДС(РеквизитыОбъекта, НастройкаЗаполнения)
	
	Если ЗначениеЗаполнено(НастройкаЗаполнения) Тогда
		Результат = ЗначениеЗаполнено(НастройкаЗаполнения.СтатьяДвиженияДенежныхСредств)
			И НастройкаЗаполнения.СтатьяДвиженияДенежныхСредств <> РеквизитыОбъекта.СтатьяДвиженияДенежныхСредств;
	Иначе
		КонтекстОперации = РеквизитыОбъекта.ВидОперации;
		ВидНалога = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(РеквизитыОбъекта.Налог, "ВидНалога");
		Если ВидНалога = Перечисления.ВидыНалогов.НалогНаПрибыль_РегиональныйБюджет
			ИЛИ ВидНалога = Перечисления.ВидыНалогов.НалогНаПрибыль_ФедеральныйБюджет Тогда
			КонтекстОперации = "НалогНаПрибыль";
		КонецЕсли;
		СтатьяДДСПоУмолчанию = УчетДенежныхСредствБП.СтатьяДДСПоУмолчанию(КонтекстОперации);
		Результат = ЗначениеЗаполнено(РеквизитыОбъекта.СтатьяДвиженияДенежныхСредств)
			И РеквизитыОбъекта.СтатьяДвиженияДенежныхСредств <> СтатьяДДСПоУмолчанию;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Сохраняем изменения только для "не поддерживаемых" налогов, т.е. для налогов, созданных пользователем.
Функция ПроверитьСтатусСоставителя(РеквизитыОбъекта, НастройкаЗаполнения, РеквизитыВБюджетПоУмолчанию, ПоддерживаемыйНалог)
	
	Если НастройкаЗаполнения = Неопределено  Тогда
		Результат = РеквизитыОбъекта.СтатусСоставителя <> РеквизитыВБюджетПоУмолчанию.СтатусСоставителя;
	Иначе
		Результат = РеквизитыОбъекта.СтатусСоставителя <> НастройкаЗаполнения.СтатусСоставителя;
	КонецЕсли;
	
	Возврат НЕ ПоддерживаемыйНалог И Результат;
	
КонецФункции

Функция ПроверитьПоказательПериода(РеквизитыОбъекта, НастройкаЗаполнения, РеквизитыВБюджетПоУмолчанию, ПоддерживаемыйНалог)
	
	Результат = Ложь;
	Если РеквизитыОбъекта.ВидПеречисленияВБюджет = Перечисления.ВидыПеречисленийВБюджет.ТаможенныйПлатеж Тогда
		// В этом случае в ПоказательПериода хранится Код таможенного органа
		Если ЗначениеЗаполнено(НастройкаЗаполнения) Тогда
			Результат = РеквизитыОбъекта.ПоказательПериода <> НастройкаЗаполнения.ПоказательПериода;
		Иначе
			Результат = ЗначениеЗаполнено(РеквизитыОбъекта.ПоказательПериода);
		КонецЕсли;
	Иначе
		ПериодичностьПлатежаВБюджет = ПлатежиВБюджетКлиентСервер.РазобратьНалоговыйПериод(РеквизитыОбъекта.ПоказательПериода);
		ПериодичностьВДокументе     = ПериодичностьПлатежаВБюджет.Периодичность;
		
		СвойстваНалога = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(РеквизитыОбъекта.Налог, "ВидНалога, КодБК");
		Если ЗначениеЗаполнено(НастройкаЗаполнения) Тогда
			ПериодичностьПлатежаВБюджет = ПлатежиВБюджетКлиентСервер.РазобратьНалоговыйПериод(НастройкаЗаполнения.ПоказательПериода);
			ПериодичностьНалогаТекущая  = ПериодичностьПлатежаВБюджет.Периодичность;
		Иначе
			Если РеквизитыВБюджетПоУмолчанию.ПоказательПериода = ПлатежиВБюджетКлиентСервер.НезаполненноеЗначение() Тогда
				ПериодичностьНалогаТекущая = ПлатежиВБюджетКлиентСервер.НезаполненноеЗначение();
			Иначе
				ПорядокУплатыНалога = ОбщегоНазначенияКлиентСервер.СвойствоСтруктуры(РеквизитыВБюджетПоУмолчанию, "ПорядокУплатыНалога");
				Если ПорядокУплатыНалога = Неопределено Тогда
					ПорядокУплатыНалога = РегистрыСведений.ЗадачиБухгалтера.ПорядокУплатыНалогаЗаПериод(
						РеквизитыОбъекта.Организация,
						СвойстваНалога.ВидНалога,
						РеквизитыОбъекта.Дата);
				КонецЕсли;
				
				Если НЕ ПоддерживаемыйНалог ИЛИ ПорядокУплатыНалога = Неопределено Тогда
					ПериодичностьПлатежаВБюджет = ПлатежиВБюджетКлиентСервер.РазобратьНалоговыйПериод(РеквизитыВБюджетПоУмолчанию.ПоказательПериода);
					ПериодичностьНалогаТекущая  = ПериодичностьПлатежаВБюджет.Периодичность;
				Иначе
					ПериодичностьНалогаТекущая  = ПлатежиВБюджетПереопределяемый.ПериодичностьПоКлассификатору(ПорядокУплатыНалога.Периодичность);
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
		
		Если НЕ ПоддерживаемыйНалог
			ИЛИ ПлатежиВБюджетКлиентСервер.ПлатежАдминистрируетсяФСС(СвойстваНалога.КодБК)
			И ПлатежиВБюджетКлиентСерверПереопределяемый.ЭтоСтраховыеВзносыФСС(СвойстваНалога.ВидНалога) Тогда
			Если ПериодичностьНалогаТекущая = ПлатежиВБюджетКлиентСервер.ПериодичностьМесяц()
				ИЛИ ПериодичностьНалогаТекущая = ПлатежиВБюджетКлиентСервер.НезаполненноеЗначение() Тогда
				Результат = ПериодичностьНалогаТекущая <> ПериодичностьВДокументе;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ПроверитьРеквизитыПолучателя(РеквизитыОбъекта, НастройкаЗаполнения, РеквизитыВБюджетПоУмолчанию, ИзмененныеНастройки)
	
	Реквизиты = РеквизитыПолучателя();
	ЗаполнитьЗначенияСвойств(Реквизиты, ИзмененныеНастройки);
	Если ЗначениеЗаполнено(НастройкаЗаполнения) И ЗначениеЗаполнено(НастройкаЗаполнения.Контрагент) Тогда
		Реквизиты.ОчиститьНастройкиПолучателя = ЗначениеЗаполнено(РеквизитыВБюджетПоУмолчанию.Получатель)
			И РеквизитыВБюджетПоУмолчанию.Получатель = РеквизитыОбъекта.Контрагент
			И ЗначениеЗаполнено(РеквизитыВБюджетПоУмолчанию.СчетПолучателя)
			И РеквизитыВБюджетПоУмолчанию.СчетПолучателя = РеквизитыОбъекта.СчетКонтрагента;
		
		Реквизиты.Получатель     = НЕ Реквизиты.ОчиститьНастройкиПолучателя
			И РеквизитыОбъекта.Контрагент <> НастройкаЗаполнения.Контрагент;
		Реквизиты.СчетПолучателя = НЕ Реквизиты.ОчиститьНастройкиПолучателя
			И (ИзмененныеНастройки.Получатель ИЛИ РеквизитыОбъекта.СчетКонтрагента <> НастройкаЗаполнения.СчетКонтрагента);
	Иначе
		// Если Получатель из документа отличается от значения "по умолчанию" и оба при этом заполнены, то если это гос.органы,
		// изменения записываем только в том случае, когда виды гос.органов не отличаются.
		// Чтобы для "налогового" платежа не могли записать получателем, например, ПФР.
		ВидыГосОргановСовпадают = Истина;
		Если ЗначениеЗаполнено(РеквизитыОбъекта.Контрагент) И ЗначениеЗаполнено(РеквизитыВБюджетПоУмолчанию.Получатель) Тогда
			ДанныеПолучателяПоУмолчанию = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(РеквизитыВБюджетПоУмолчанию.Получатель,
				"ГосударственныйОрган, ВидГосударственногоОргана");
			ДанныеКонтрагента = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(РеквизитыОбъекта.Контрагент,
				"ГосударственныйОрган, ВидГосударственногоОргана");
			Если ДанныеКонтрагента.ГосударственныйОрган И ДанныеПолучателяПоУмолчанию.ГосударственныйОрган Тогда
				ВидыГосОргановСовпадают = ДанныеКонтрагента.ВидГосударственногоОргана = ДанныеПолучателяПоУмолчанию.ВидГосударственногоОргана;
			КонецЕсли;
		КонецЕсли;
		
		ВладелецСчетаПолучателя = Справочники.Контрагенты.ПустаяСсылка();
		Если ЗначениеЗаполнено(РеквизитыОбъекта.СчетКонтрагента) Тогда
			ВладелецСчетаПолучателя = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(РеквизитыОбъекта.СчетКонтрагента, "Владелец");
		КонецЕсли;
		
		Реквизиты.Получатель     = НЕ ЗначениеЗаполнено(РеквизитыВБюджетПоУмолчанию.Получатель)
			ИЛИ ВидыГосОргановСовпадают И РеквизитыВБюджетПоУмолчанию.Получатель <> РеквизитыОбъекта.Контрагент;
		Реквизиты.СчетПолучателя = ИзмененныеНастройки.Получатель
			ИЛИ НЕ ЗначениеЗаполнено(РеквизитыВБюджетПоУмолчанию.СчетПолучателя)
			ИЛИ (РеквизитыВБюджетПоУмолчанию.СчетПолучателя <> РеквизитыОбъекта.СчетКонтрагента
			// Рассматриваем отличие р/с только у одного и того же получателя, т.к. в ином случае сработает ИзмененныеНастройки.Получатель.
				И ВладелецСчетаПолучателя = РеквизитыВБюджетПоУмолчанию.Получатель);
	КонецЕсли;
	
	Возврат Реквизиты;
	
КонецФункции

Функция ПроверитьКодТерритории(РеквизитыОбъекта, НастройкаЗаполнения, РеквизитыВБюджетПоУмолчанию, ПравилаЗаполнения)
	
	Если Не ПравилаЗаполнения.СохранятьКодТерриторииПриЗаписи Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Если НастройкаЗаполнения = Неопределено Тогда
		Возврат РеквизитыОбъекта.КодТерритории <> РеквизитыВБюджетПоУмолчанию.КодОКАТО;
	КонецЕсли;
	
	Если Не НастройкаЗаполнения.Свойство("КодТерритории") Тогда
		Возврат Истина;
	КонецЕсли;
	
	Возврат НастройкаЗаполнения.КодТерритории <> РеквизитыОбъекта.КодТерритории;
	
КонецФункции

Функция НовыйПравилаЗаполненияРеквизитовПлатежа()
	
	Правила = Новый Структура;
	// Определяет, нужно ли заполнять автоматически данные получателя по данными регистрации.
	// Как правило, налог уплачивается в ту налоговую, в которой организация или ИП зарегистрированы.
	// В этом случае нужно указывать ЗаполнятьПолучателя = Истина и при заполнении платежного поручения
	// будет указана налоговая, в котором организация зарегистрирована.
	// Но для некоторых налогов, например, НПД, налог нужно уплачивать не по месту нахождения организации,
	// а по данным уведомления по уплате налога из налоговой. В этом случае автоматически заполнять получателя
	// не нужно, пользователь сам укажет нужные значения.
	Правила.Вставить("ЗаполнятьПолучателя", Истина);
	
	// Определяет, нужно ли заполнять автоматически код территории (ОКТМО) по данным регистрации.
	// Для большинства налогов код территории (ОКТМО) определяется регистрацией.
	// Но для некоторых налогов, например, НПД, нужно подставлять код территории, который указан 
	// в уведомлении налоговой об уплате налога и он не соответствует коду территории регистрации.
	// Для таких налогов нужно указать ЗаполнятьКодТерриторииПоРегистрации = Ложь и пользователь укажет эти
	// данные самостоятельно.
	Правила.Вставить("ЗаполнятьКодТерриторииПоРегистрации", Истина);
	
	// Определяет, нужно ли сохранять при записи банковских документов код терртории (ОКТМО),
	// если пользователь его изменил.
	// Как правило, код территории (ОКТМО) всегда определяется из регистрации и эти изменения сохранять не нужно,
	// но для некоторых налогов, например, НДП, код территории заполняется вручную и его нужно сохранить.
	Правила.Вставить("СохранятьКодТерриторииПриЗаписи", Ложь);
	
	Возврат Правила;
	
КонецФункции

#КонецОбласти
