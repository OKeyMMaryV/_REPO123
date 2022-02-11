﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Открывает диалог группового изменения реквизитов для выбранных в списке объектов.
//
// Параметры:
//  СписокЭлемент  - ТаблицаФормы       - элемент формы со списком;
//  СписокРеквизит - ДинамическийСписок - реквизит формы со списком.
//
Процедура ИзменитьВыделенные(СписокЭлемент, Знач СписокРеквизит = Неопределено) Экспорт
	
	Если СписокРеквизит = Неопределено Тогда
		Форма = СписокЭлемент.Родитель;
		Пока ТипЗнч(Форма) <> Тип("ФормаКлиентскогоПриложения") Цикл
			Форма = Форма.Родитель;
		КонецЦикла;
		
		Попытка
			СписокРеквизит = Форма.Список;
		Исключение
			СписокРеквизит = Неопределено;
		КонецПопытки;
	КонецЕсли;
	
	ВыделенныеСтроки = СписокЭлемент.ВыделенныеСтроки;
	
	ПараметрыФормы = Новый Структура("МассивОбъектов", Новый Массив);
	Если ТипЗнч(СписокРеквизит) = Тип("ДинамическийСписок") Тогда
		ПараметрыФормы.Вставить("КомпоновщикНастроек", СписокРеквизит.КомпоновщикНастроек);
	КонецЕсли;
	
	Для Каждого ВыделеннаяСтрока Из ВыделенныеСтроки Цикл
		Если ТипЗнч(ВыделеннаяСтрока) = Тип("СтрокаГруппировкиДинамическогоСписка") Тогда
			Продолжить;
		КонецЕсли;
		
		ТекущаяСтрока = СписокЭлемент.ДанныеСтроки(ВыделеннаяСтрока);
		Если ТекущаяСтрока <> Неопределено Тогда
			ПараметрыФормы.МассивОбъектов.Добавить(ТекущаяСтрока.Ссылка);
		КонецЕсли;
	КонецЦикла;
	
	Если ПараметрыФормы.МассивОбъектов.Количество() = 0 Тогда
		ПоказатьПредупреждение(, НСтр("ru = 'Команда не может быть выполнена для указанного объекта.'"));
		Возврат;
	КонецЕсли;
		
	ОткрытьФорму("Обработка.ГрупповоеИзменениеРеквизитов.Форма", ПараметрыФормы);
	
КонецПроцедуры

#КонецОбласти
