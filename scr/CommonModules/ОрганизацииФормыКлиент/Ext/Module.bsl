﻿
////////////////////////////////////////////////////////////////////////////////
// Универсальные методы для справочника Организации
//
// Клиентские методы форм справочника Организации
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

Процедура ПерейтиКСервисуОпределитьРеквизитыИФНС() Экспорт
	
	ПерейтиПоНавигационнойСсылке(АдресСервисаОпределитьРеквизитыИФНС());
	
КонецПроцедуры

Процедура ПерейтиКСервисуСкачатьКвитанциюНаОплатуГоспошлиныПриРегистрации() Экспорт
	
	ПерейтиПоНавигационнойСсылке(АдресСервисаОплатаГоспошлиныПриРегистрации());
	
КонецПроцедуры

Процедура ПерейтиКСервисуУплатаГоспошлины() Экспорт
	
	ПерейтиПоНавигационнойСсылке(АдресСервисаУплатаГоспошлины());
	
КонецПроцедуры

Процедура ПерейтиКСервисуУзнатьИНН() Экспорт
	
	ПерейтиПоНавигационнойСсылке(АдресСервисаУзнатьИНН());
	
КонецПроцедуры

Процедура ОткрытьДемоверсию() Экспорт
	
	АдресДемобазы = ОрганизацииФормыВызовСервера.АдресДемобазы();
	Если ЗначениеЗаполнено(АдресДемобазы) Тогда
		ПерейтиПоНавигационнойСсылке(АдресДемобазы);
	КонецЕсли;
	
КонецПроцедуры

// Обработчик вызова помощника для регистрации организации по новому адресу нахождения подразделения.
//
// Параметры:
//     Форма                - ФормаКлиентскогоПриложения - Форма владельца контактной информации (форма организации или подразделения).
//     ИмяЭлементаАдреса    - Строка - Имя реквизита формы и элемента формы (должны совпадать), содержащие представление адреса.
//     ПараметрыФормы   	- Структура - параметры открываемой формы, установленные вне данной процедуры в дополнение к обязательным.
//     ЭтоОрганизация   	- Булево - признак, что помощник вызывается из формы организации.
//
Процедура ОткрытьФормуПомощникаСменыАдреса(Форма, ИмяЭлементаАдреса, ОповещениеЗавершения, ПараметрыФормы = Неопределено) Экспорт 
			
	Объект = Форма.Объект;
			
	ДанныеСтрокиКИ = УправлениеКонтактнойИнформациейБПКлиентСервер.ЗначениеКонтактнойИнформацииФормы(
		Форма,
		ИмяЭлементаАдреса);
		
	// На форме механизмом БСП должен быть создан реквизит для хранения полей адреса.
	// Если реквизит не найден, то вызовем ошибку.
	Если ДанныеСтрокиКИ = Неопределено Тогда
		ТекстОшибки = НСтр("ru='Не найден реквизит формы для хранения адреса:
						|%1'");
		ТекстОшибки = СтрШаблон(ТекстОшибки, Форма.Элементы[ИмяЭлементаАдреса]);
		ВызватьИсключение ТекстОшибки;
	КонецЕсли;	
	
	ПараметрыАдреса = Новый Структура;
	ПараметрыАдреса.Вставить("ТекстРедактирования", Форма[ИмяЭлементаАдреса]);
	ПараметрыАдреса.Вставить("ЗначениеАдресаJSON", ДанныеСтрокиКИ.Значение);
	
	Если ПараметрыФормы = Неопределено Тогда
		ПараметрыФормы = Новый Структура;
	КонецЕсли;	
	
	ПараметрыФормы.Вставить("СтруктурнаяЕдиница", 					Объект.Ссылка);
	ПараметрыФормы.Вставить("ПрежняяРегистрацияВНалоговомОргане", 	Форма.РегистрацияВНалоговомОргане.Ссылка);
	ПараметрыФормы.Вставить("ПрежнийАдрес", 						ПараметрыАдреса);
	ПараметрыФормы.Вставить("ВидКИ", 								ДанныеСтрокиКИ.Вид);
	
	ОткрытьФорму("Справочник.ПодразделенияОрганизаций.Форма.ПостановкаНаУчетПоНовомуАдресу",
		ПараметрыФормы,
		Форма,
		,
		,
		,
		ОповещениеЗавершения,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);	
	
КонецПроцедуры

// Обработчик вызова помощника для снятия подразделения с учета в налоговом органе (закрытие КПП).
//
// Параметры:
//     Форма  	- ФормаКлиентскогоПриложения - Форма владельца контактной информации (форма организации или подразделения).
//     РегистрацияВНалоговомОрганеСсылка 
//				- СправочникСсылка.РегистрацииВНалоговомОргане - ссылка на регистрацию, которую нужно закрыть.
//
Процедура ОткрытьФормуПомощникаСнятияСУчета(Форма, РегистрацияВНалоговомОрганеСсылка, ОповещениеЗавершения) Экспорт 
	
	ПараметрыФормы = Новый Структура("РегистрацияВНалоговомОргане", РегистрацияВНалоговомОрганеСсылка);
	
	ОткрытьФорму("Справочник.ПодразделенияОрганизаций.Форма.СнятиеСУчетаВНалоговомОргане",
		ПараметрыФормы,
		Форма,
		,
		,
		,
		ОповещениеЗавершения,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ОбновитьСистемаНалогообложения(ПараметрыУчетнойПолитики, Форма) Экспорт
	
	Объект = Форма.Объект;
	
	Если ПараметрыУчетнойПолитики <> Неопределено Тогда // организация ещё не записывалась в базу
		ОбщегоНазначенияКлиентСервер.ДополнитьСтруктуру(Форма.СтруктураУчетнойПолитики, ПараметрыУчетнойПолитики, Истина);
		Форма.СистемаНалогообложенияПредставление = ОрганизацииФормыКлиентСервер.ПредставлениеСистемыНалогообложения(Форма.СтруктураУчетнойПолитики);
	ИначеЕсли Не Объект.Ссылка.Пустая() Тогда // изменяем текущую политику у ранее созданной организации
		Форма.СистемаНалогообложенияПредставление = ОрганизацииФормыКлиентСервер.ПредставлениеСистемыНалогообложения(Объект.Ссылка);
	КонецЕсли;
	ОформитьПредставлениеСистемыНалогообложения(Форма);
	
КонецПроцедуры

Процедура ОформитьПредставлениеСистемыНалогообложения(Форма) Экспорт
	
	Элементы = Форма.Элементы;
	
	Если ЗначениеЗаполнено(Форма.СистемаНалогообложенияПредставление) Тогда
		Если Форма.ВидОрганизации = "ОбособленноеПодразделение" И Форма.Параметры.Ключ.Пустая() Тогда
			// Система налогообложения обособленного подразделения не выбирается, т.к. не может отличаться от головной организации.
			Элементы.СистемаНалогообложенияПредставление.Гиперссылка = Ложь;
			Элементы.СистемаНалогообложенияПредставление.ЦветТекста = ОбщегоНазначенияКлиентПовтИсп.ЦветСтиля("НезаполненныйРеквизит");
		Иначе
			Элементы.СистемаНалогообложенияПредставление.Гиперссылка = Истина;
			Элементы.СистемаНалогообложенияПредставление.ЦветТекста = ОбщегоНазначенияКлиентПовтИсп.ЦветСтиля("ЦветГиперссылки");
		КонецЕсли;
	Иначе
		Форма.СистемаНалогообложенияПредставление = НСтр("ru = '<Не указана система налогообложения>'");
		Элементы.СистемаНалогообложенияПредставление.Гиперссылка = Ложь;
		Элементы.СистемаНалогообложенияПредставление.ЦветТекста = ОбщегоНазначенияКлиентПовтИсп.ЦветСтиля("НезаполненныйРеквизит");
	КонецЕсли;
	
КонецПроцедуры

Функция ФИОПриИзменении(Объект) Экспорт
	
	ОбновитьПредставление = Ложь;
	
	Если ЗначениеЗаполнено(Объект.ФамилияИП) Или ЗначениеЗаполнено(Объект.ИмяИП) Или ЗначениеЗаполнено(Объект.ОтчествоИП) Тогда
		
		Объект.НаименованиеСокращенное = ОрганизацииФормыКлиентСервер.СокращенноеНаименованиеИндивидуальногоПредпринимателя(
			Объект.ФамилияИП, Объект.ИмяИП, Объект.ОтчествоИП);
		
		Объект.НаименованиеПолное = ОрганизацииФормыКлиентСервер.ПолноеНаименованиеИндивидуальногоПредпринимателя(
			Объект.ФамилияИП, Объект.ИмяИП, Объект.ОтчествоИП);
		
		Объект.Наименование = ОрганизацииФормыКлиентСервер.НаименованиеИндивидуальногоПредпринимателя(
			Объект.ФамилияИП, Объект.ИмяИП, Объект.ОтчествоИП);
		
		ОбновитьПредставление = Истина;
		
	КонецЕсли;
	
	Возврат ОбновитьПредставление;
	
КонецФункции

Функция АдресСервисаОпределитьРеквизитыИФНС()
	
	Возврат "https://service.nalog.ru/addrno.do";
	
КонецФункции

Функция АдресСервисаОплатаГоспошлиныПриРегистрации()
	
	Возврат "https://service.nalog.ru/gp2.do";
	
КонецФункции

Функция АдресСервисаУплатаГоспошлины()
	
	Возврат "https://service.nalog.ru/inn.do";
	
КонецФункции

Функция АдресСервисаУзнатьИНН()
	
	Возврат "https://service.nalog.ru/inn.do";
	
КонецФункции

Процедура ПоказатьВопросИзменитьКодНалоговогоОргана(Знач КПП, Знач КодНалоговогоОргана, ОповещениеЗавершения) Экспорт	
		
	ТекстВопроса = НСтр("ru = 'Текущий код налоговой инспекции %1 не соответствует первым цифрам введенного КПП %2.
					|Обновить код налоговой инспекции?'");
	ТекстВопроса = СтрШаблон(ТекстВопроса, КодНалоговогоОргана, КПП);
	
	ПоказатьВопрос(ОповещениеЗавершения, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
	
КонецПроцедуры	

// Функция определяет дату последней записи в истории регистраций на форме организации или подразделения
Функция АктуальныйПериодИсторииРегистраций(Форма) Экспорт
	
	АктуальныйПериодИсторииРегистраций = '0001-01-01';
	
	// Т.к. таблица истории регистраций отсортирована по периоду, то достаточно взять период из последней записи.
	Если Форма.ИсторияРегистрацийВНалоговомОрганеНаборЗаписей.Количество() > 0 Тогда
		АктуальнаяЗапись = Форма.ИсторияРегистрацийВНалоговомОрганеНаборЗаписей[Форма.ИсторияРегистрацийВНалоговомОрганеНаборЗаписей.Количество() - 1];
		АктуальныйПериодИсторииРегистраций = АктуальнаяЗапись.Период;
	КонецЕсли;	
	
	Возврат АктуальныйПериодИсторииРегистраций;
	
КонецФункции

// Функция определяет дату последней записи в истории контактной информации на форме организации
Функция АктуальныйПериодИсторииКонтактнойИнформации(Форма, ВидКонтактнойИнформации) Экспорт
		
	АктуальныйПериодКИ = '0001-01-01';
	Отбор = Новый Структура("Вид", ВидКонтактнойИнформации);
	Для Каждого ЗаписьИстории ИЗ  Форма.Объект.ИсторияКонтактнойИнформации.НайтиСтроки(Отбор) Цикл
		Если ЗаписьИстории.Период > АктуальныйПериодКИ Тогда
			АктуальныйПериодКИ = ЗаписьИстории.Период;
		КонецЕсли;
	КонецЦикла;	
			
	Возврат АктуальныйПериодКИ;

КонецФункции

#КонецОбласти


