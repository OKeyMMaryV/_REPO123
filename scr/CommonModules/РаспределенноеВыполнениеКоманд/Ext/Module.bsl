﻿////////////////////////////////////////////////////////////////////////////////
// РаспределенноеВыполнениеКоманд: управление выполнением команд внешних
// (дополнительных) обработок в прикладных информационных базах.
////////////////////////////////////////////////////////////////////////////////

// Экспортные процедуры и функции для вызова из других модулей
// 
#Область ПрограммныйИнтерфейс

// Вызывает команду указанной дополнительной обработки и передает в нее параметры,
// регистрирует сообщение для МС с результатами выполнения.
// Важно! Вызывается как фоновое задание.
//
// Параметры:
//	ИдентификаторОбработки - Строка - указывает на обработку, команду которой нужно выполнить.
//	ИдентификаторКоманды - Строка - имя команды (как оно задано в обработке), которую нужно выполнить.
//	ИдентификаторОперации - Строка - позволяет идентифицировать отдельные вызовы (например, для логирования).
//	СообщитьМенеджеру - Булево - указывает на необходимость сообщить Менеджеру сервиса о результате выполнения команды. 
//
Процедура ВыполнитьКомандуДополнительнойОбработки(ИдентификаторОбработки, ИдентификаторКоманды, ИдентификаторОперации, СообщитьМенеджеру = Ложь) Экспорт
	
	ОшибкаВыполнения = Ложь;
	РезультатВыполнения = "";
	
	// Ищем версию дополнительной обработки.
	
	Запрос = Новый Запрос();
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
	|	ПоставляемыеДополнительныеОтчетыИОбработки.Ссылка КАК ПоставляемаяОбработка,
	|	ИспользованиеПоставляемыхДополнительныхОтчетовИОбработокВОбластяхДанных.ИспользуемаяОбработка КАК Ссылка
	|ИЗ
	|	Справочник.ПоставляемыеДополнительныеОтчетыИОбработки КАК ПоставляемыеДополнительныеОтчетыИОбработки
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.ИспользованиеПоставляемыхДополнительныхОтчетовИОбработокВОбластяхДанных КАК ИспользованиеПоставляемыхДополнительныхОтчетовИОбработокВОбластяхДанных
	|		ПО ПоставляемыеДополнительныеОтчетыИОбработки.Ссылка = ИспользованиеПоставляемыхДополнительныхОтчетовИОбработокВОбластяхДанных.ПоставляемаяОбработка
	|ГДЕ
	|	ПоставляемыеДополнительныеОтчетыИОбработки.ПометкаУдаления = ЛОЖЬ
	|	И ПоставляемыеДополнительныеОтчетыИОбработки.ИмяОбъекта = &ИмяОбъекта";
	
	Запрос.УстановитьПараметр("ИмяОбъекта", Строка(ИдентификаторОбработки));
	Выборка = Запрос.Выполнить().Выбрать();
	
	Событие = ИмяСобытияЖурналаРегистрации() + ".";
	Событие = Событие + НСтр("ru = 'Начало выполнения команды'", ОбщегоНазначения.КодОсновногоЯзыка()); 
	Комментарий = НСтр("ru = 'Начинаем выполнение команды %1 (обработка %2, вызов %3).'");
	Комментарий = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Комментарий, ИдентификаторКоманды, 
																	ИдентификаторОбработки, ИдентификаторОперации);
	ЗаписьЖурналаРегистрации(Событие, УровеньЖурналаРегистрации.Информация,,, Комментарий);
	
	Если Выборка.Следующий() Тогда
		
		ПараметрыВыполнения = Новый Структура();
		ПараметрыВыполнения.Вставить("ДополнительнаяОбработкаСсылка", Выборка.Ссылка);
		ПараметрыВыполнения.Вставить("ИдентификаторКоманды", ИдентификаторКоманды);
		
		Попытка
			
			РезультатОбработки = ДополнительныеОтчетыИОбработки.ВыполнитьКоманду(ПараметрыВыполнения);
			РезультатВыполнения = НСтр("ru = 'Команда выполнена успешно.'");
			
			Событие = ИмяСобытияЖурналаРегистрации() + ".";
			Событие = Событие + НСтр("ru = 'Завершение выполнения команды'", ОбщегоНазначения.КодОсновногоЯзыка()); 
			Комментарий = НСтр("ru = 'Выполнение команды %1 (обработка %2, вызов %3) завершено.'");
			Комментарий = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Комментарий, ИдентификаторКоманды, 
			ИдентификаторОбработки, ИдентификаторОперации);
			ЗаписьЖурналаРегистрации(Событие, УровеньЖурналаРегистрации.Информация,,, Комментарий);	
			
		Исключение
			ОшибкаВыполнения = Истина;
			Событие = НСтр("ru = 'Ошибка выполнения команды'", ОбщегоНазначения.КодОсновногоЯзыка()); 
			Комментарий = НСтр("ru = 'При выполнении команды возникла ошибка'"); 
			ТекстОшибки = ОписаниеОшибки();
			СделатьЗаписьОбОшибке(Событие, Комментарий, ТекстОшибки);
			РезультатВыполнения = Комментарий + ": " + ТекстОшибки;
		КонецПопытки; 
	Иначе
		ОшибкаВыполнения = Истина;
		Событие = НСтр("ru = 'Обработка не найдена'", ОбщегоНазначения.КодОсновногоЯзыка()); 
		Комментарий = НСтр("ru = 'Не удалось найти внешнюю обработку по идентификатору'"); 
		ТекстОшибки = Строка(ИдентификаторОбработки);
		СделатьЗаписьОбОшибке(Событие, Комментарий, ТекстОшибки);
		РезультатВыполнения = Комментарий + ": " + ТекстОшибки;
	КонецЕсли; 
	
	Если НЕ СообщитьМенеджеру Тогда
		Возврат;
	КонецЕсли; 
	
	ТипСообщения = СообщенияРаспределенноеВыполнениеКомандИнтерфейс.ТипОбратныйВызов();
	Сообщение = СообщенияВМоделиСервиса.НовоеСообщение(ТипСообщения);
	Сообщение.Body.Zone = РаботаВМоделиСервиса.ЗначениеРазделителяСеанса();
	Сообщение.Body.Call_ID = ИдентификаторОперации;
	Сообщение.Body.Error = ОшибкаВыполнения;
	Сообщение.Body.ResultInfo = РезультатВыполнения;
	
	// Сообщаем результат выполнения Менеджеру Сервиса.
	
	НачатьТранзакцию();
	Попытка
		Получатель = РаботаВМоделиСервисаПовтИсп.КонечнаяТочкаМенеджераСервиса();
		СообщенияВМоделиСервиса.ОтправитьСообщение(Сообщение, Получатель, Истина);	
		
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;
	
КонецПроцедуры // ВыполнитьКомандуДополнительнойОбработки() 

// Вызывает команду передачи файла из текущей области данных в любую другую область 
// данных сервиса.
// Важно! Если какой-либо из параметров передан некорректно, вызывается исключение.
//
// Параметры:
//	ИмяФайла - Строка - полное имя к передаваемому файлу.
//	КодПолучателя - Число - код области данных, куда нужно передать файл.
//	БыстраяПередача - Булево - указывает, что необходимо использовать быстрые сообщения для передачи файла. 
//	ПараметрыВызова - Структура - дополнительные параметры вызова,
//						*Код (Число), *Тело (Строка).
//
// Возвращаемое значение:
//   УникальныйИдентификатор   - GUID вызова.
//
Функция ВыполнитьПередачуФайлаПриложению(ИмяФайла, КодПолучателя, БыстраяПередача = Ложь, ПараметрыВызова = Неопределено) Экспорт

	КодЯзыка = ОбщегоНазначения.КодОсновногоЯзыка();
		
	// Проверяем существование файла.
	
	Указатель = Новый Файл(ИмяФайла);
	Если НЕ Указатель.Существует() Тогда
		Комментарий = НСтр("ru = 'Файл с указанным именем не найден на файловой системе.'", КодЯзыка); 
		ВызватьИсключение Комментарий;
	КонецЕсли; 
	
	// Проверяем код получателя.
	
	Если НЕ ЗначениеЗаполнено(КодПолучателя) И НЕ ТипЗнч(КодПолучателя) = Тип("Число") Тогда
		Комментарий = НСтр("ru = 'Параметр КодПолучателя не содержит валидный код области данных.'", КодЯзыка); 
		ВызватьИсключение Комментарий;
	КонецЕсли; 
	
	// Помещаем файл в общее хранилище МС.
	
	УстановитьПривилегированныйРежим(Истина);
	
	ИдентификаторВызова = Новый УникальныйИдентификатор();
	
	ДвоичныеДанныеФайла = Новый ДвоичныеДанные(ИмяФайла);
	ИдентификаторФайла = РаботаВМоделиСервиса.ПоместитьФайлВХранилищеМенеджераСервиса(ДвоичныеДанныеФайла);
	
	// Формируем и отправляем сообщение.
	
	ТипСообщения = СообщенияРаспределенноеВыполнениеКомандИнтерфейс.ТипПередачаФайлаЗапрос();
	Сообщение = СообщенияВМоделиСервиса.НовоеСообщение(ТипСообщения);
	Сообщение.Body.Zone = РаботаВМоделиСервиса.ЗначениеРазделителяСеанса();
	Сообщение.Body.Call_ID = ИдентификаторВызова;
	Сообщение.Body.File_ID = ИдентификаторФайла;
	Сообщение.Body.Sender = Сообщение.Body.Zone;
	Сообщение.Body.Recipient = КодПолучателя;
	Сообщение.Body.RapidTransfer = БыстраяПередача;
	
	Если НЕ ПараметрыВызова = Неопределено И ТипЗнч(ПараметрыВызова) = Тип("Структура") Тогда
		
		Если ПараметрыВызова.Свойство("Код") Тогда
			Сообщение.Body.CallCode = ПараметрыВызова.Код;
		КонецЕсли; 
		
		Если ПараметрыВызова.Свойство("Тело") Тогда
			Сообщение.Body.CallBody = ПараметрыВызова.Тело;
		КонецЕсли; 
		
	КонецЕсли; 
	
	// Высылаем сообщение МС.
	
	НачатьТранзакцию();
	Попытка
		Получатель = РаботаВМоделиСервисаПовтИсп.КонечнаяТочкаМенеджераСервиса();
		СообщенияВМоделиСервиса.ОтправитьСообщение(Сообщение, Получатель, БыстраяПередача);	
		
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;
	
	УстановитьПривилегированныйРежим(Ложь);
	
	Возврат ИдентификаторВызова;

КонецФункции // ВыполнитьПередачуФайлаПриложению() 

// Отправляет области-получателю сообщение-квитанцию о получении (завершении обработки,
// и так далее) ранее полученного файла.
// Важно! Если какой-либо из параметров передан некорректно, вызывается исключение.
//
// Параметры:
//	ИдентификаторВызова - УникальныйИдентификатор - ранее выданный функцией ВыполнитьПередачуФайлаПриложению
//	КодПолучателя - Число - код области данных, куда нужно передать квитанцию.
//	БыстраяПередача - Булево - указывает, что необходимо использовать быстрые сообщения для передачи файла. 
//	ПараметрыВызова - Структура - дополнительные параметры вызова,
//						*Код (Число), *Тело (Строка).
//
//
Процедура ВыслатьКвитанциюПередачиФайла(ИдентификаторВызова, КодПолучателя, БыстраяПередача = Ложь, ПараметрыВызова = Неопределено) Экспорт

	КодЯзыка = ОбщегоНазначения.КодОсновногоЯзыка();
		
	// Проверяем входящие параметры.
	
	Если НЕ ЗначениеЗаполнено(ИдентификаторВызова) ИЛИ НЕ ТипЗнч(ИдентификаторВызова) = Тип("УникальныйИдентификатор") Тогда
		Комментарий = НСтр("ru = 'Параметр ИдентификаторВызова не содержит валидный идентификатор.'", КодЯзыка); 
		ВызватьИсключение Комментарий;
	КонецЕсли; 
	
	Если НЕ ЗначениеЗаполнено(КодПолучателя) И НЕ ТипЗнч(КодПолучателя) = Тип("Число") Тогда
		Комментарий = НСтр("ru = 'Параметр КодПолучателя не содержит валидный код области данных.'", КодЯзыка); 
		ВызватьИсключение Комментарий;
	КонецЕсли; 
	
	// Формируем и отправляем сообщение.
	
	УстановитьПривилегированныйРежим(Истина);
	
	ТипСообщения = СообщенияРаспределенноеВыполнениеКомандИнтерфейс.ТипПередачаФайлаОтвет();
	Сообщение = СообщенияВМоделиСервиса.НовоеСообщение(ТипСообщения);
	Сообщение.Body.Zone = РаботаВМоделиСервиса.ЗначениеРазделителяСеанса();
	Сообщение.Body.Call_ID = ИдентификаторВызова;
	Сообщение.Body.Sender = Сообщение.Body.Zone;
	Сообщение.Body.Recipient = КодПолучателя;
	Сообщение.Body.Error = Ложь;
	Сообщение.Body.RapidTransfer = БыстраяПередача;
	
	Если НЕ ПараметрыВызова = Неопределено И ТипЗнч(ПараметрыВызова) = Тип("Структура") Тогда
		
		Если ПараметрыВызова.Свойство("Код") Тогда
			Сообщение.Body.CallCode = ПараметрыВызова.Код;
		КонецЕсли; 
		
		Если ПараметрыВызова.Свойство("Тело") Тогда
			Сообщение.Body.CallBody = ПараметрыВызова.Тело;
		КонецЕсли; 
		
	КонецЕсли; 
	
	// Высылаем сообщение МС.
	
	НачатьТранзакцию();
	Попытка
		Получатель = РаботаВМоделиСервисаПовтИсп.КонечнаяТочкаМенеджераСервиса();
		СообщенияВМоделиСервиса.ОтправитьСообщение(Сообщение, Получатель, БыстраяПередача);
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;
	
	УстановитьПривилегированныйРежим(Ложь);

КонецПроцедуры // ВыслатьКвитанциюПередачиФайла() 

#КонецОбласти  

// Экспортные процедуры и функции для вызова из других модулей подсистемы.

// Важно! Служебный программный интерфейс может существенно изменяться со временем.
// 
#Область СлужебныйПрограммныйИнтерфейс

// Возвращает ключ, который используется для хранения настроек обработки в "безопасном хранилище".
//
// Параметры:
//  нет
//
// Возвращаемое значение:
//   Строка   - ключ для записи/чтения в "безопасном хранилище"
//
Функция КлючБезопасногоХранилища() Экспорт

	Возврат "ПараметрыПакетногоВызова";

КонецФункции // КлючБезопасногоХранилища() 

// Возвращает старшее имя события для записей в ЖР
//
// Параметры:
//  нет
//
// Возвращаемое значение:
//   Строка   - имя события
//
Функция ИмяСобытияЖурналаРегистрации() Экспорт

	Возврат НСтр("ru = 'Распределенное выполнение команд'", ОбщегоНазначения.КодОсновногоЯзыка()); 

КонецФункции // ИмяСобытияЖурналаРегистрации() 

// Записывает в журнал регистрации информацию об ошибке
//
// Параметры:
//	ИмяСобытия - Строка - Младшее имя события в ЖР 
//	Комментарий - Строка - Информация о типе ошибки 
//	ТекстОшибки - Строка - Техническая информация, полученная в Исключении 
//	Данные - Произвольный - Для записи в одноименное поле журнала 
//
Процедура СделатьЗаписьОбОшибке(ИмяСобытия, Комментарий, ТекстОшибки, Данные = Неопределено) Экспорт

	Комментарий = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Комментарий + ": %1", ТекстОшибки);
	Событие = ИмяСобытияЖурналаРегистрации() + "." + ИмяСобытия;
	Уровень = УровеньЖурналаРегистрации.Ошибка;
	
	ЗаписьЖурналаРегистрации(Событие, Уровень,, Данные, Комментарий);	

КонецПроцедуры // СделатьЗаписьОбОшибке() 

// См. ОчередьЗаданийПереопределяемый.ПриОпределенииПсевдонимовОбработчиков.
Процедура ПриОпределенииПсевдонимовОбработчиков(СоответствиеИменПсевдонимам) Экспорт 
	
	СоответствиеИменПсевдонимам.Вставить("РаспределенноеВыполнениеКоманд.ВыполнитьКомандуДополнительнойОбработки");
	
КонецПроцедуры

#КонецОбласти 
