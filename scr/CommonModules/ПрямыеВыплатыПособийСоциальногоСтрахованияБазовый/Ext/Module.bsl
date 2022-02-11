﻿#Область СлужебныйПрограммныйИнтерфейс

// Заполняет табличные части документа "ИсходящаяСправкаОЗаработкеДляРасчетаПособий".
//
// Параметры:
//  Объект -  ДокументОбъект.ИсходящаяСправкаОЗаработкеДляРасчетаПособий
//  ПараметрыЗаполнения - см. ПараметрыЗаполненияСправкиОЗаработкеИДняхОтсутствия.
//
// Возвращаемое значение:
//	Истина, если данные в объекте были обновлены.
//
Функция ЗаполнитьСправкуДаннымиОЗаработкеИДняхОтсутствия(Объект, ПараметрыЗаполнения) Экспорт
	
	Если ПараметрыЗаполнения.Обновление Тогда
		
		МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
		СоздатьВТДанныеОЗаработкеДляЗаполнения(МенеджерВременныхТаблиц, ПараметрыЗаполнения);
		Модифицирован = ФиксацияВторичныхДанныхВДокументах.ОбновитьВторичныеДанные(МенеджерВременныхТаблиц, Объект, "ДанныеОЗаработке", "ВТДанныеОЗаработкеДляЗаполнения");
		
	Иначе
		
		Объект.ДанныеОЗаработке.Загрузить(ДанныеОЗаработкеДляЗаполнения(ПараметрыЗаполнения));
		Модифицирован = Истина;
		
	КонецЕсли;
	
	Возврат Модифицирован;
	
КонецФункции

// Формирует параметры для создания временных таблиц используемых для заполнения справки о заработке для расчета
// пособий.
//
// Параметры:
//  Объект - ДокументОбъект.СправкаОЗаработкеДляРасчетаПособий.
//
// Возвращаемое значение:
//    Структура:
//		ГодНачало
//		ГодОкончание
//		Сотрудник
//		Организация
//      ПоВсемОП - данные по Организации или по ГоловнойОрганизации.
//      Обновление - учитывать ли зафиксированные в документе реквизиты.
//      РасчетныеГоды - отбор заполняемых лет, входящих в период между ГодНачало и ГодОкончание.
//      ОграничиватьРазмерЗаработка - применять ли ограничение базой страховых взносов.
//
Функция ПараметрыЗаполненияСправкиОЗаработкеИДняхОтсутствия(Объект = Неопределено) Экспорт
	ПараметрыЗаполненияСправки = Новый Структура("ГодНачала, ГодОкончания, Сотрудник, Организация, ПоВсемОП, Обновление, РасчетныеГоды, ОграничиватьРазмерЗаработка");
	ПараметрыЗаполненияСправки.ПоВсемОП = Ложь;
	ПараметрыЗаполненияСправки.Обновление = Ложь;
	ПараметрыЗаполненияСправки.РасчетныеГоды = Неопределено;
	ПараметрыЗаполненияСправки.ОграничиватьРазмерЗаработка = Истина;
	Возврат ПараметрыЗаполненияСправки
КонецФункции

// Возвращает таблицу с данными о заработке сотрудника по годам.
//
// Параметры:
//  ПараметрыЗаполнения - Структура, состав см. в
//                        УчетПособийСоциальногоСтрахования.ПараметрыЗаполненияСправкиОЗаработкеИДняхОтсутствия.
//
// Возвращаемое значение:
//  Таблица значений с колонками:
//		РасчетныйГод
//		Заработок
//
Функция ДанныеОЗаработкеДляЗаполнения(ПараметрыЗаполнения) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	СоздатьВТДанныеОЗаработкеДляЗаполнения(Запрос.МенеджерВременныхТаблиц, ПараметрыЗаполнения);
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ДанныеОЗаработкеДляЗаполнения.РасчетныйГод,
	|	ДанныеОЗаработкеДляЗаполнения.Заработок
	|ИЗ
	|	ВТДанныеОЗаработкеДляЗаполнения КАК ДанныеОЗаработкеДляЗаполнения";
	
	Возврат Запрос.Выполнить().Выгрузить();
	
КонецФункции

// Возвращает массив ссылок из ПВР Начисления, соответствующих облагаемым взносами компенсациям, возмещаемым из бюджета ФСС
// (в частности, оплата 4-х дополнительных выходных дней для ухода за детьми инвалидами).
//
// Параметры:
//	нет
//
// Возвращаемое значение:
//	Массив
//
Функция НачисленияОблагаемыхВзносамиПособий() Экспорт

	Возврат Новый Массив()
	
КонецФункции

// Функция - Категории начислений пособий по прямым выплатам ФСС
//
// Возвращаемое значение:
//  МассивКатегорий - Массив, категории пособий, которые оплачиваются напрямую ФСС.
//
Функция КатегорииНачисленийПособийПоПрямымВыплатамФСС() Экспорт
	
	МассивКатегорий = Новый Массив;
	МассивКатегорий.Добавить(Перечисления.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоЛиста);
	МассивКатегорий.Добавить(Перечисления.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоНесчастныйСлучайНаПроизводстве);
	МассивКатегорий.Добавить(Перечисления.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоПрофзаболевание);
	МассивКатегорий.Добавить(Перечисления.КатегорииНачисленийИНеоплаченногоВремени.ОтпускПоБеременностиИРодам);
	
	Возврат МассивКатегорий;
	
КонецФункции

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

Процедура ЗаполнитьПризнакВыплачиваетсяФСССуществующихДокументов(МенеджерВременныхТаблиц) Экспорт
		
КонецПроцедуры

Процедура СоздатьВТДанныеОЗаработкеДляЗаполнения(МенеджерВременныхТаблиц, ПараметрыЗаполнения)
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	Запрос.УстановитьПараметр("ФизическоеЛицо", ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ПараметрыЗаполнения.Сотрудник, "ФизическоеЛицо"));
	Запрос.УстановитьПараметр("ГоловнаяОрганизация", ЗарплатаКадры.ГоловнаяОрганизация(ПараметрыЗаполнения.Организация));
	Запрос.УстановитьПараметр("ОграничиватьРазмерЗаработка", ПараметрыЗаполнения.ОграничиватьРазмерЗаработка);
	
	Запрос.Текст =
		"ВЫБРАТЬ
		|	&ФизическоеЛицо КАК ФизическоеЛицо,
		|	&ГоловнаяОрганизация КАК ГоловнаяОрганизация
		|ПОМЕСТИТЬ ВТФизЛицаОрганизаций";
		
	Запрос.Выполнить();
	
	УчетСтраховыхВзносов.СформироватьВТРасширенныеСведенияОДоходахИВзносах(Дата(ПараметрыЗаполнения.ГодНачала, 1, 1), КонецГода(Дата(ПараметрыЗаполнения.ГодОкончания, 1, 1)), ПараметрыЗаполнения.Организация, Запрос.МенеджерВременныхТаблиц, Истина, , , , Истина);
	
	ТекстЗапроса =
		"ВЫБРАТЬ
		|	ГОД(СведенияОДоходах.Период) КАК РасчетныйГод,
		|	СУММА(СведенияОДоходах.БазаФСС - СведенияОДоходах.СуммаПревысившаяПределФСС) КАК Заработок
		|ПОМЕСТИТЬ ВТДанныеОЗаработкеБезОграничения
		|ИЗ
		|	ВТРасширенныеСведенияОДоходах КАК СведенияОДоходах
		|ГДЕ
		|	&ОтборПоОрганизации
		|
		|СГРУППИРОВАТЬ ПО
		|	ГОД(СведенияОДоходах.Период)
		|
		|ИМЕЮЩИЕ
		|	СУММА(СведенияОДоходах.БазаФСС - СведенияОДоходах.СуммаПревысившаяПределФСС) <> 0
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ДанныеОЗаработке.РасчетныйГод,
		|	СУММА(ВЫБОР
		|			КОГДА ДанныеОЗаработке.Заработок >= ПредельнаяВеличинаБазыСтраховыхВзносов.РазмерФСС
		|					И &ОграничиватьРазмерЗаработка
		|				ТОГДА ПредельнаяВеличинаБазыСтраховыхВзносов.РазмерФСС
		|			ИНАЧЕ ДанныеОЗаработке.Заработок
		|		КОНЕЦ) КАК Заработок
		|ПОМЕСТИТЬ ВТДанныеОЗаработкеДляЗаполнения
		|ИЗ
		|	(ВЫБРАТЬ
		|		МАКСИМУМ(ПредельнаяВеличинаБазыСтраховыхВзносов.Период) КАК Период,
		|		ДанныеОЗаработке.РасчетныйГод КАК РасчетныйГод,
		|		ДанныеОЗаработке.Заработок КАК Заработок
		|	ИЗ
		|		ВТДанныеОЗаработкеБезОграничения КАК ДанныеОЗаработке
		|			ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПредельнаяВеличинаБазыСтраховыхВзносов КАК ПредельнаяВеличинаБазыСтраховыхВзносов
		|			ПО (ДанныеОЗаработке.РасчетныйГод >= ГОД(ПредельнаяВеличинаБазыСтраховыхВзносов.Период))
		|
		|	СГРУППИРОВАТЬ ПО
		|		ДанныеОЗаработке.РасчетныйГод,
		|		ДанныеОЗаработке.Заработок) КАК ДанныеОЗаработке
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПредельнаяВеличинаБазыСтраховыхВзносов КАК ПредельнаяВеличинаБазыСтраховыхВзносов
		|		ПО ДанныеОЗаработке.Период = ПредельнаяВеличинаБазыСтраховыхВзносов.Период
		|ГДЕ
		|	ДанныеОЗаработке.РасчетныйГод В(&РасчетныеГоды)
		|
		|СГРУППИРОВАТЬ ПО
		|	ДанныеОЗаработке.РасчетныйГод";
	
	Если ПараметрыЗаполнения.ПоВсемОП Тогда
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса,"&ОтборПоОрганизации","Истина");
	Иначе
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса,"&ОтборПоОрганизации","СведенияОДоходах.Организация = &Организация");
		Запрос.УстановитьПараметр("Организация", ПараметрыЗаполнения.Организация);
	КонецЕсли;
	
	Если ПараметрыЗаполнения.РасчетныеГоды = Неопределено Тогда
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "ДанныеОЗаработке.РасчетныйГод В(&РасчетныеГоды)", "ИСТИНА");
	Иначе
		Запрос.УстановитьПараметр("РасчетныеГоды", ПараметрыЗаполнения.РасчетныеГоды);
	КонецЕсли;
	
	Запрос.Текст = ТекстЗапроса;
	
	Запрос.Выполнить();
	
КонецПроцедуры

#Область ЗаявлениеВФССОВозмещенииВыплатРодителямДетейИнвалидов

Функция ДанныеЗаполненияЗаявленияВФССОВозмещенииВыплатРодителямДетейИнвалидов(Документ, ОплатаДнейУходаЗаДетьмиИнвалидами) Экспорт
	 Возврат Неопределено;
КонецФункции

#Область ОписаниеФиксацииРеквизитовЗаявленияВФССОВозмещенииВыплатРодителямДетейИнвалидов

Функция ОписаниеФиксацииРеквизитовЗаявленияВФССОВозмещенииВыплатРодителямДетейИнвалидов() Экспорт
	ФиксируемыеРеквизиты = Новый Соответствие;
	
	// Реквизиты организации.
	Шаблон = ФиксацияВторичныхДанныхВДокументах.ОписаниеФиксируемогоРеквизита();
	Шаблон.ИмяГруппы           = "Организация";
	Шаблон.ОснованиеЗаполнения = "Организация";
	
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "НаименованиеТерриториальногоОрганаФСС");
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "РегистрационныйНомерФСС");
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "ДополнительныйКодФСС");
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "КодПодчиненностиФСС");
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "ИНН");
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "КПП");
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "АдресОрганизации");
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "АдресЭлектроннойПочтыОрганизации");
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "ТелефонСоставителя");
	
	// Роль подписанта Руководитель.
	Шаблон = ФиксацияВторичныхДанныхВДокументах.ОписаниеФиксируемогоРеквизита();
	Шаблон.ОснованиеЗаполнения      = "Организация";
	Шаблон.ИмяГруппы                = "Руководитель";
	Шаблон.ФиксацияГруппы           = Истина;
	Шаблон.ОтображатьПредупреждение = Ложь;
	
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "Руководитель");
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "ДолжностьРуководителя");
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "ОснованиеПодписиРуководителя");
	
	Возврат Новый ФиксированноеСоответствие(ФиксируемыеРеквизиты);
КонецФункции

#КонецОбласти

Функция ИспользуетсяЗаполнениеДокументаЗаявлениеВФССОВозмещенииВыплатРодителямДетейИнвалидов() Экспорт
	Возврат Ложь;
КонецФункции

#КонецОбласти

#Область ЗаявлениеВФССОВозмещенииРасходовНаПогребение

Функция ДанныеЗаполненияЗаявленияВФССОВозмещенииРасходовНаПогребение(Организация, Ссылка, ЕдиновременноеПособие = Неопределено) Экспорт
	Возврат Неопределено;
КонецФункции

#Область ОписаниеФиксацииРеквизитовЗаявленияВФССОВозмещенииРасходовНаПогребение

Функция ОписаниеФиксацииРеквизитовЗаявленияВФССОВозмещенииРасходовНаПогребение() Экспорт
	ФиксируемыеРеквизиты = Новый Соответствие;
	
	// Реквизиты организации.
	Шаблон = ФиксацияВторичныхДанныхВДокументах.ОписаниеФиксируемогоРеквизита();
	Шаблон.ИмяГруппы           = "Организация";
	Шаблон.ОснованиеЗаполнения = "Организация";
	
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "НаименованиеТерриториальногоОрганаФСС");
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "РегистрационныйНомерФСС");
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "ДополнительныйКодФСС");
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "КодПодчиненностиФСС");
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "ИНН");
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "КПП");
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "АдресОрганизации");
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "АдресЭлектроннойПочтыОрганизации");
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "ТелефонСоставителя");
	
	// Роль подписанта Руководитель.
	Шаблон = ФиксацияВторичныхДанныхВДокументах.ОписаниеФиксируемогоРеквизита();
	Шаблон.ОснованиеЗаполнения      = "Организация";
	Шаблон.ИмяГруппы                = "Руководитель";
	Шаблон.ФиксацияГруппы           = Истина;
	Шаблон.ОтображатьПредупреждение = Ложь;
	
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "Руководитель");
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "ДолжностьРуководителя");
	ФиксацияВторичныхДанныхВДокументах.ДобавитьФиксируемыйРеквизит(ФиксируемыеРеквизиты, Шаблон, "ОснованиеПодписиРуководителя");
	
	Возврат Новый ФиксированноеСоответствие(ФиксируемыеРеквизиты);
КонецФункции

#КонецОбласти

Функция ИспользуетсяЗаполнениеЗаявленияВФССОВозмещенииРасходовНаПогребение() Экспорт
	Возврат Ложь;
КонецФункции

#КонецОбласти

#Область ЗаявлениеСотрудникаНаВыплатуПособия

Функция БанковскиеРеквизитыСотрудникаДляВыплатыЗарплаты(Дата, Организация, Сотрудник, ФизическоеЛицо) Экспорт
	Результат = Новый Структура("Банк, НомерСчета");
	
	ТаблицаЛицевыхСчетов = ОбменСБанкамиПоЗарплатнымПроектам.ЛицевыеСчетаСотрудников(
		ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Сотрудник),
		Истина,
		Организация,
		Дата);
	
	Если ТаблицаЛицевыхСчетов.Количество() > 0 Тогда
		ТаблицаЛицевыхСчетов.Сортировать("МесяцОткрытия Убыв");
		Результат.Банк       = ТаблицаЛицевыхСчетов[0].Банк;
		Результат.НомерСчета = ТаблицаЛицевыхСчетов[0].НомерЛицевогоСчета;
	КонецЕсли;
	
	Возврат Результат;
КонецФункции

Функция РайонныйКоэффициентРФПодразделенияОрганизацииДляЗаявленияСотрудникаНаВыплатуПособия(Организация, Подразделение = Неопределено) Экспорт
	
	Возврат Неопределено;
	
КонецФункции

Функция ТипДокументаОснованияЗаявленияСотрудникаНаВыплатуПособия(Заявление) Экспорт
	
	Если Заявление.ВидПособия = Перечисления.ПособияНазначаемыеФСС.ОтпускСверхЕжегодногоНаПериодЛечения Тогда
		Возврат Тип("ДокументСсылка.Отпуск");
	КонецЕсли;
	
	Возврат Тип("ДокументСсылка.БольничныйЛист");
	
КонецФункции

Функция СписокДетейПоУходуЗаКоторымиПредоставленОтпуск(ДокументОснование) Экспорт
	
	ДанныеОДетях = Новый СписокЗначений;
	
	Возврат ДанныеОДетях;
	
КонецФункции

Функция ВидПособияИмеетДокументОснование(ВидПособия) Экспорт
	
	ВидПособияИмеетДокументОснование = Ложь;
	
	Если ВидПособия = Перечисления.ПособияНазначаемыеФСС.ПособиеПоВременнойНетрудоспособности
		Или ВидПособия = Перечисления.ПособияНазначаемыеФСС.ПособиеВСвязиСНесчастнымСлучаемНаПроизводстве
		Или ВидПособия = Перечисления.ПособияНазначаемыеФСС.ПособиеПоБеременностиИРодам
		Или ВидПособия = Перечисления.ПособияНазначаемыеФСС.ПособиеПоБеременностиИРодамВставшимНаУчетВРанниеСроки
		Или ВидПособия = Перечисления.ПособияНазначаемыеФСС.ОтпускСверхЕжегодногоНаПериодЛечения Тогда
		ВидПособияИмеетДокументОснование = Истина;
	КонецЕсли;
	
	Возврат ВидПособияИмеетДокументОснование;
	
КонецФункции

Функция ДоляРабочегоВремениСотрудника(Сотрудник, Дата) Экспорт
	
	Возврат 1;
	
КонецФункции

Процедура ДобавитьКомандыПечатиЗаявленияСотрудникаНаВыплатуПособия(КомандыПечати) Экспорт
	
КонецПроцедуры

#КонецОбласти

#Область РеестрСведенийНеобходимыхДляНазначенияИВыплатыПособий

Процедура ПриОпределенииЗапросаРеестраПрямыхВыплатПоПервичнымДокументам(Запрос, Объект, ТаблицаОснований) Экспорт
	
	Если Объект.ВидРеестра = Перечисления.ВидыРеестровСведенийНеобходимыхДляНазначенияИВыплатыПособий.ПособияПоНетрудоспособности Тогда
		ПриОпределенииЗапросаРеестраПрямыхВыплатПоБольничнымЛистам(Запрос, ТаблицаОснований);
		
	ИначеЕсли Объект.ВидРеестра = Перечисления.ВидыРеестровСведенийНеобходимыхДляНазначенияИВыплатыПособий.ЕжемесячныеПособияПоУходуЗаРебенком Тогда
		ПриОпределенииЗапросаРеестраПрямыхВыплатПоОтпускамПоУходу(Запрос, ТаблицаОснований);
		
	ИначеЕсли Объект.ВидРеестра = Перечисления.ВидыРеестровСведенийНеобходимыхДляНазначенияИВыплатыПособий.ЕдиновременныеПособияПриРожденииРебенка Тогда
		ПриОпределенииЗапросаРеестраПрямыхВыплатПоЕдиновременнымПособиямПриРождении(Запрос, ТаблицаОснований);
		
	ИначеЕсли Объект.ВидРеестра = Перечисления.ВидыРеестровСведенийНеобходимыхДляНазначенияИВыплатыПособий.ПособияВставшимНаУчетВРанниеСроки Тогда
		ПриОпределенииЗапросаРеестраПрямыхВыплатПоПособиямВставшимНаУчетВРанниеСроки(Запрос, ТаблицаОснований);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриОпределенииЗапросаРеестраПрямыхВыплатПоБольничнымЛистам(Запрос, ТаблицаОснований)
	
	Запрос.УстановитьПараметр("МассивКатегорий", ПрямыеВыплатыПособийСоциальногоСтрахования.КатегорииНачисленийПособийПоПрямымВыплатамФСС());
	
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ВТЗаявления.Заявление КАК Заявление,
	|	МИНИМУМ(БольничныйЛистНачисления.ДатаНачала) КАК ДатаНачала,
	|	МАКСИМУМ(БольничныйЛистНачисления.ДатаОкончания) КАК ДатаОкончания
	|ПОМЕСТИТЬ ВТПериодыОплатыЗаСчетФСС
	|ИЗ
	|	ВТЗаявления КАК ВТЗаявления
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.БольничныйЛист.Начисления КАК БольничныйЛистНачисления
	|			ЛЕВОЕ СОЕДИНЕНИЕ ПланВидовРасчета.Начисления КАК Начисления
	|			ПО БольничныйЛистНачисления.Начисление = Начисления.Ссылка
	|		ПО ВТЗаявления.ДокументОснование = БольничныйЛистНачисления.Ссылка
	|ГДЕ
	|	Начисления.КатегорияНачисленияИлиНеоплаченногоВремени В(&МассивКатегорий)
	|
	|СГРУППИРОВАТЬ ПО
	|	ВТЗаявления.Заявление
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ВТЗаявления.Заявление КАК Заявление,
	|	БольничныйЛист.Ссылка КАК ПервичныйДокумент,
	|	БольничныйЛист.ПредоставленДубликатЛисткаНетрудоспособности КАК ПредоставленДубликатЛисткаНетрудоспособности,
	|	НЕ БольничныйЛист.ЯвляетсяПродолжениемБолезни КАК ЯвляетсяПервичнымЛисткомНетрудоспособности,
	|	ЕСТЬNULL(СведенияОбЭЛН.Хэш, """") <> """" КАК ЭтоЭЛН,
	|	БольничныйЛист.НомерПервичногоЛисткаНетрудоспособности КАК НомерПервичногоЛисткаНетрудоспособности,
	|	БольничныйЛист.МедицинскаяОрганизация КАК МедицинскаяОрганизация,
	|	БольничныйЛист.НаименованиеМедицинскойОрганизации КАК НаименованиеМедицинскойОрганизации,
	|	БольничныйЛист.АдресМедицинскойОрганизации КАК АдресМедицинскойОрганизации,
	|	БольничныйЛист.ОГРНМедицинскойОрганизации КАК ОГРНМедицинскойОрганизации,
	|	БольничныйЛист.НомерЛисткаНетрудоспособности КАК НомерЛисткаНетрудоспособности,
	|	БольничныйЛист.ДатаВыдачиЛисткаНетрудоспособности КАК ДатаВыдачиЛисткаНетрудоспособности,
	|	БольничныйЛист.КодПричиныНетрудоспособности КАК КодПричиныНетрудоспособности,
	|	БольничныйЛист.ДополнительныйКодПричиныНетрудоспособности КАК ДополнительныйКодПричиныНетрудоспособности,
	|	БольничныйЛист.ВторойКодПричиныНетрудоспособности КАК ВторойКодПричиныНетрудоспособности,
	|	БольничныйЛист.НаименованиеОрганизацииВЛисткеНетрудоспособности КАК НаименованиеОрганизацииВЛисткеНетрудоспособности,
	|	БольничныйЛист.ОсновноеМестоРаботы КАК ОсновноеМестоРаботы,
	|	БольничныйЛист.НомерЛисткаПоОсновномуМестуРаботы КАК НомерЛисткаПоОсновномуМестуРаботы,
	|	БольничныйЛист.ДатаИзмененияКодаПричиныНетрудоспособности КАК ДатаИзмененияКодаПричиныНетрудоспособности,
	|	БольничныйЛист.ДатаОкончанияПутевки КАК ДатаОкончанияПутевки,
	|	БольничныйЛист.НомерПутевки КАК НомерПутевки,
	|	БольничныйЛист.ОГРН_Санатория КАК ОГРН_Санатория,
	|	БольничныйЛист.ПоУходуВозрастЛет1 КАК ПоУходуВозрастЛет1,
	|	БольничныйЛист.ПоУходуВозрастМесяцев1 КАК ПоУходуВозрастМесяцев1,
	|	БольничныйЛист.ПоУходуРодственнаяСвязь1 КАК ПоУходуРодственнаяСвязь1,
	|	БольничныйЛист.ПоУходуФИО1 КАК ПоУходуФИО1,
	|	БольничныйЛист.ПоУходуИспользованоДней1 КАК ПоУходуИспользованоДней1,
	|	БольничныйЛист.ПоУходуВозрастЛет2 КАК ПоУходуВозрастЛет2,
	|	БольничныйЛист.ПоУходуВозрастМесяцев2 КАК ПоУходуВозрастМесяцев2,
	|	БольничныйЛист.ПоУходуРодственнаяСвязь2 КАК ПоУходуРодственнаяСвязь2,
	|	БольничныйЛист.ПоУходуФИО2 КАК ПоУходуФИО2,
	|	БольничныйЛист.ПоУходуИспользованоДней2 КАК ПоУходуИспользованоДней2,
	|	БольничныйЛист.ПоставленаНаУчетВРанниеСрокиБеременности КАК ПоставленаНаУчетВРанниеСрокиБеременности,
	|	БольничныйЛист.КодНарушенияРежима КАК КодНарушенияРежима,
	|	БольничныйЛист.ДатаНарушенияРежима КАК ДатаНарушенияРежима,
	|	БольничныйЛист.ПериодНахожденияВСтационареСРебенкомС КАК ПериодНахожденияВСтационареСРебенкомС,
	|	БольничныйЛист.ПериодНахожденияВСтационареСРебенкомПо КАК ПериодНахожденияВСтационареСРебенкомПо,
	|	БольничныйЛист.ДатаНаправленияВБюроМСЭ КАК ДатаНаправленияВБюроМСЭ,
	|	БольничныйЛист.ДатаРегистрацииДокументовМСЭ КАК ДатаРегистрацииДокументовМСЭ,
	|	БольничныйЛист.ДатаОсвидетельствованияМСЭ КАК ДатаОсвидетельствованияМСЭ,
	|	БольничныйЛист.ГруппаИнвалидности КАК ГруппаИнвалидности,
	|	БольничныйЛист.ОсвобождениеДатаНачала1 КАК ОсвобождениеДатаНачала1,
	|	БольничныйЛист.ОсвобождениеДатаОкончания1 КАК ОсвобождениеДатаОкончания1,
	|	БольничныйЛист.ОсвобождениеДолжностьВрача1 КАК ОсвобождениеДолжностьВрача1,
	|	БольничныйЛист.ОсвобождениеФИОВрача1 КАК ОсвобождениеФИОВрача1,
	|	БольничныйЛист.ОсвобождениеИдентификационныйНомерВрача1 КАК ОсвобождениеИдентификационныйНомерВрача1,
	|	БольничныйЛист.ОсвобождениеФИОВрачаПредседателяВК1 КАК ОсвобождениеФИОВрачаПредседателяВК1,
	|	БольничныйЛист.ОсвобождениеДолжностьВрачаПредседателяВК1 КАК ОсвобождениеДолжностьВрачаПредседателяВК1,
	|	БольничныйЛист.ОсвобождениеИдентификационныйНомерВрачаПредседателяВК1 КАК ОсвобождениеИдентификационныйНомерВрачаПредседателяВК1,
	|	БольничныйЛист.ОсвобождениеДатаНачала2 КАК ОсвобождениеДатаНачала2,
	|	БольничныйЛист.ОсвобождениеДатаОкончания2 КАК ОсвобождениеДатаОкончания2,
	|	БольничныйЛист.ОсвобождениеДолжностьВрача2 КАК ОсвобождениеДолжностьВрача2,
	|	БольничныйЛист.ОсвобождениеФИОВрача2 КАК ОсвобождениеФИОВрача2,
	|	БольничныйЛист.ОсвобождениеИдентификационныйНомерВрача2 КАК ОсвобождениеИдентификационныйНомерВрача2,
	|	БольничныйЛист.ОсвобождениеФИОВрачаПредседателяВК2 КАК ОсвобождениеФИОВрачаПредседателяВК2,
	|	БольничныйЛист.ОсвобождениеДолжностьВрачаПредседателяВК2 КАК ОсвобождениеДолжностьВрачаПредседателяВК2,
	|	БольничныйЛист.ОсвобождениеИдентификационныйНомерВрачаПредседателяВК2 КАК ОсвобождениеИдентификационныйНомерВрачаПредседателяВК2,
	|	БольничныйЛист.ОсвобождениеДатаНачала3 КАК ОсвобождениеДатаНачала3,
	|	БольничныйЛист.ОсвобождениеДатаОкончания3 КАК ОсвобождениеДатаОкончания3,
	|	БольничныйЛист.ОсвобождениеДолжностьВрача3 КАК ОсвобождениеДолжностьВрача3,
	|	БольничныйЛист.ОсвобождениеФИОВрача3 КАК ОсвобождениеФИОВрача3,
	|	БольничныйЛист.ОсвобождениеИдентификационныйНомерВрача3 КАК ОсвобождениеИдентификационныйНомерВрача3,
	|	БольничныйЛист.ОсвобождениеФИОВрачаПредседателяВК3 КАК ОсвобождениеФИОВрачаПредседателяВК3,
	|	БольничныйЛист.ОсвобождениеДолжностьВрачаПредседателяВК3 КАК ОсвобождениеДолжностьВрачаПредседателяВК3,
	|	БольничныйЛист.ОсвобождениеИдентификационныйНомерВрачаПредседателяВК3 КАК ОсвобождениеИдентификационныйНомерВрачаПредседателяВК3,
	|	БольничныйЛист.ПриступитьКРаботеС КАК ПриступитьКРаботеС,
	|	БольничныйЛист.ДатаНовыйСтатусНетрудоспособного КАК ДатаНовыйСтатусНетрудоспособного,
	|	БольничныйЛист.НовыйСтатусНетрудоспособного КАК НовыйСтатусНетрудоспособного,
	|	БольничныйЛист.НомерЛисткаПродолжения КАК НомерЛисткаПродолжения,
	|	БольничныйЛист.УсловияИсчисленияКод1 КАК УсловияИсчисленияКод1,
	|	БольничныйЛист.УсловияИсчисленияКод2 КАК УсловияИсчисленияКод2,
	|	БольничныйЛист.УсловияИсчисленияКод3 КАК УсловияИсчисленияКод3,
	|	БольничныйЛист.ДатаАктаН1 КАК ДатаАктаН1,
	|	БольничныйЛист.ДатаНачалаРаботы КАК ДатаНачалаРаботы,
	|	БольничныйЛист.ФинансированиеФедеральнымБюджетом КАК ФинансированиеФедеральнымБюджетом,
	|	ВТПериодыОплатыЗаСчетФСС.ДатаНачала КАК ДатаНачалаОплаты,
	|	ВТПериодыОплатыЗаСчетФСС.ДатаОкончания КАК ДатаОкончанияОплаты,
	|	ВТЗаявления.УдалитьИзвещениеИзФССНомер КАК ИзвещениеИзФССНомер,
	|	ВТЗаявления.УдалитьИзвещениеИзФССДата КАК ИзвещениеИзФССДата,
	|	ВЫБОР
	|		КОГДА ВТЗаявления.УдалитьИзвещениеИзФССНомер <> """"
	|				ИЛИ ВТРанееПринятыеРеестры.Ссылка ЕСТЬ НЕ NULL 
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК ИзвещениеИзФССИспользование
	|ИЗ
	|	ВТЗаявления КАК ВТЗаявления
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.БольничныйЛист КАК БольничныйЛист
	|		ПО ВТЗаявления.ДокументОснование = БольничныйЛист.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТПериодыОплатыЗаСчетФСС КАК ВТПериодыОплатыЗаСчетФСС
	|		ПО ВТЗаявления.Заявление = ВТПериодыОплатыЗаСчетФСС.Заявление
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.СведенияОбЭЛН КАК СведенияОбЭЛН
	|		ПО ВТЗаявления.НомерЛисткаНетрудоспособности = СведенияОбЭЛН.НомерЛисткаНетрудоспособности
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТРанееПринятыеРеестры КАК ВТРанееПринятыеРеестры
	|		ПО ВТЗаявления.Заявление = ВТРанееПринятыеРеестры.Заявление";
	
КонецПроцедуры

Процедура ПриОпределенииЗапросаРеестраПрямыхВыплатПоОтпускамПоУходу(Запрос, ТаблицаОснований)
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ВТЗаявления.Заявление КАК Заявление,
	|	ЗаявлениеСотрудникаНаВыплатуПособия.ФамилияРебенка КАК ФамилияРебенка,
	|	ЗаявлениеСотрудникаНаВыплатуПособия.ИмяРебенка КАК ИмяРебенка,
	|	ЗаявлениеСотрудникаНаВыплатуПособия.ОтчествоРебенка КАК ОтчествоРебенка,
	|	ЗаявлениеСотрудникаНаВыплатуПособия.ДатаРожденияРебенка КАК ДатаРожденияРебенка,
	|	ВЫБОР
	|		КОГДА НЕ ЗаявлениеСотрудникаНаВыплатуПособия.ДатаСвидетельстваОРождении = ДАТАВРЕМЯ(1, 1, 1)
	|			ТОГДА ЗНАЧЕНИЕ(ПЕРЕЧИСЛЕНИЕ.ВидыПодтверждающихДокументовОтпускаПоУходу.СвидетельствоОРождении)
	|		КОГДА НЕ ЗаявлениеСотрудникаНаВыплатуПособия.ДатаРешенияОбОпеке = ДАТАВРЕМЯ(1, 1, 1)
	|			ТОГДА ЗНАЧЕНИЕ(ПЕРЕЧИСЛЕНИЕ.ВидыПодтверждающихДокументовОтпускаПоУходу.РешениеОбУстановленииОпеки)
	|		КОГДА НЕ ЗаявлениеСотрудникаНаВыплатуПособия.ДатаИногоДокументаПодтверждающегоРождение = ДАТАВРЕМЯ(1, 1, 1)
	|			ТОГДА ЗНАЧЕНИЕ(ПЕРЕЧИСЛЕНИЕ.ВидыПодтверждающихДокументовОтпускаПоУходу.ИнойДокументПодтверждающийРождениеРебенка)
	|	КОНЕЦ КАК ВидПодтверждающегоДокумента,
	|	ВЫБОР
	|		КОГДА НЕ ЗаявлениеСотрудникаНаВыплатуПособия.ДатаСвидетельстваОРождении = ДАТАВРЕМЯ(1, 1, 1)
	|			ТОГДА ЗаявлениеСотрудникаНаВыплатуПособия.ДатаСвидетельстваОРождении
	|		КОГДА НЕ ЗаявлениеСотрудникаНаВыплатуПособия.ДатаРешенияОбОпеке = ДАТАВРЕМЯ(1, 1, 1)
	|			ТОГДА ЗаявлениеСотрудникаНаВыплатуПособия.ДатаРешенияОбОпеке
	|		КОГДА НЕ ЗаявлениеСотрудникаНаВыплатуПособия.ДатаИногоДокументаПодтверждающегоРождение = ДАТАВРЕМЯ(1, 1, 1)
	|			ТОГДА ЗаявлениеСотрудникаНаВыплатуПособия.ДатаИногоДокументаПодтверждающегоРождение
	|	КОНЕЦ КАК ДатаДокумента,
	|	ВЫБОР
	|		КОГДА НЕ ЗаявлениеСотрудникаНаВыплатуПособия.ДатаСвидетельстваОРождении = ДАТАВРЕМЯ(1, 1, 1)
	|			ТОГДА ЗаявлениеСотрудникаНаВыплатуПособия.СерияСвидетельстваОРождении
	|	КОНЕЦ КАК СерияДокумента,
	|	ВЫБОР
	|		КОГДА НЕ ЗаявлениеСотрудникаНаВыплатуПособия.ДатаСвидетельстваОРождении = ДАТАВРЕМЯ(1, 1, 1)
	|			ТОГДА ЗаявлениеСотрудникаНаВыплатуПособия.НомерСвидетельстваОРождении
	|		КОГДА НЕ ЗаявлениеСотрудникаНаВыплатуПособия.ДатаРешенияОбОпеке = ДАТАВРЕМЯ(1, 1, 1)
	|			ТОГДА ЗаявлениеСотрудникаНаВыплатуПособия.НомерРешенияОбОпеке
	|		КОГДА НЕ ЗаявлениеСотрудникаНаВыплатуПособия.ДатаИногоДокументаПодтверждающегоРождение = ДАТАВРЕМЯ(1, 1, 1)
	|			ТОГДА ЗаявлениеСотрудникаНаВыплатуПособия.НомерИногоДокументаПодтверждающегоРождение
	|	КОНЕЦ КАК НомерДокумента,
	|	ЗаявлениеСотрудникаНаВыплатуПособия.ФинансированиеФедеральнымБюджетом КАК ФинансированиеФедеральнымБюджетом,
	|	ВТЗаявления.УдалитьИзвещениеИзФССНомер КАК ИзвещениеИзФССНомер,
	|	ВТЗаявления.УдалитьИзвещениеИзФССДата КАК ИзвещениеИзФССДата,
	|	ВЫБОР
	|		КОГДА ВТЗаявления.УдалитьИзвещениеИзФССНомер <> """"
	|				ИЛИ ВТРанееПринятыеРеестры.Ссылка ЕСТЬ НЕ NULL 
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК ИзвещениеИзФССИспользование
	|ИЗ
	|	ВТЗаявления КАК ВТЗаявления
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ЗаявлениеСотрудникаНаВыплатуПособия КАК ЗаявлениеСотрудникаНаВыплатуПособия
	|		ПО ВТЗаявления.Заявление = ЗаявлениеСотрудникаНаВыплатуПособия.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТРанееПринятыеРеестры КАК ВТРанееПринятыеРеестры
	|		ПО ВТЗаявления.Заявление = ВТРанееПринятыеРеестры.Заявление";
	
КонецПроцедуры

Процедура ПриОпределенииЗапросаРеестраПрямыхВыплатПоЕдиновременнымПособиямПриРождении(Запрос, ТаблицаОснований)
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ВТЗаявления.Заявление КАК Заявление,
	|	ВТЗаявления.УдалитьИзвещениеИзФССНомер КАК ИзвещениеИзФССНомер,
	|	ВТЗаявления.УдалитьИзвещениеИзФССДата КАК ИзвещениеИзФССДата,
	|	ВЫБОР
	|		КОГДА ВТЗаявления.УдалитьИзвещениеИзФССНомер <> """"
	|				ИЛИ ВТРанееПринятыеРеестры.Ссылка ЕСТЬ НЕ NULL 
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК ИзвещениеИзФССИспользование
	|ИЗ
	|	ВТЗаявления КАК ВТЗаявления
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТРанееПринятыеРеестры КАК ВТРанееПринятыеРеестры
	|		ПО ВТЗаявления.Заявление = ВТРанееПринятыеРеестры.Заявление";
	
КонецПроцедуры

Процедура ПриОпределенииЗапросаРеестраПрямыхВыплатПоПособиямВставшимНаУчетВРанниеСроки(Запрос, ТаблицаОснований)
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ВТЗаявления.Заявление КАК Заявление,
	|	ВТЗаявления.УдалитьИзвещениеИзФССНомер КАК ИзвещениеИзФССНомер,
	|	ВТЗаявления.УдалитьИзвещениеИзФССДата КАК ИзвещениеИзФССДата,
	|	ВЫБОР
	|		КОГДА ВТЗаявления.УдалитьИзвещениеИзФССНомер <> """"
	|				ИЛИ ВТРанееПринятыеРеестры.Ссылка ЕСТЬ НЕ NULL 
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК ИзвещениеИзФССИспользование
	|ИЗ
	|	ВТЗаявления КАК ВТЗаявления
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТРанееПринятыеРеестры КАК ВТРанееПринятыеРеестры
	|		ПО ВТЗаявления.Заявление = ВТРанееПринятыеРеестры.Заявление";
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

