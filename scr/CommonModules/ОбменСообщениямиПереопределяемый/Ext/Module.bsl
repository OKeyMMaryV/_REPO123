﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2018, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Получает список обработчиков сообщений, которые обрабатывает
// данная информационная система.
// 
// Параметры:
//  Обработчики -  - ТаблицаЗначений - с колонками:
//    * Канал - Строка - Канал сообщения.
//    * Обработчик - ОбщийМодуль - Обработчик сообщения.
//
//@skip-warning Пустой метод
Процедура ПолучитьОбработчикиКаналовСообщений(Обработчики) Экспорт
	
КонецПроцедуры

// Обработчик получения динамического списка конечных точек сообщений.
//
// Параметры:
//  КаналСообщений - Строка - Идентификатор канала сообщений, для которого необходимо определить конечные точки.
//  Получатели     - Массив - Массив конечных точек, в которые следует адресовать сообщение,
//                            должен быть заполнен элементами типа ПланОбменаСсылка.ОбменСообщениями.
//                            Этот параметр необходимо определить в теле обработчика.
//
//@skip-warning Пустой метод
Процедура ПолучателиСообщения(Знач КаналСообщений, Получатели) Экспорт
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Обработчики событий отправки и получения сообщений.

// Обработчик события при отправке сообщения.
// Обработчик данного события вызывается перед помещением сообщения в XML-поток.
// Обработчик вызывается для каждого отправляемого сообщения.
//
// Параметры:
//  КаналСообщений - Строка - Идентификатор канала сообщений, в который отправляется сообщение.
//  ТелоСообщения - Произвольный - Тело отправляемого сообщения. В обработчике события тело сообщения
//                                может быть изменено, например, дополнено информацией.
//
//@skip-warning Пустой метод
Процедура ПриОтправкеСообщения(КаналСообщений, ТелоСообщения) Экспорт
	
КонецПроцедуры

// Обработчик события при получении сообщения.
// Обработчик данного события вызывается при получении сообщения из XML-потока.
// Обработчик вызывается для каждого получаемого сообщения.
//
// Параметры:
//  КаналСообщений - Строка - Идентификатор канала сообщений, из которого получено сообщение.
//  ТелоСообщения - Произвольный - Тело полученного сообщения. В обработчике события тело сообщения
//                                 может быть изменено, например, дополнено информацией.
//
//@skip-warning Пустой метод
Процедура ПриПолученииСообщения(КаналСообщений, ТелоСообщения) Экспорт
	
КонецПроцедуры

#КонецОбласти
