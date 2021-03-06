////////////////////////////////////////////////////////////////////////////////
// Модуль содержит методы работы с универсальными коллекциями значений.
// 
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

// Функция удаляет повторяющиеся элементы массива.
// 
Функция УдалитьПовторяющиесяЭлементыМассива(Массив, НеИспользоватьНеопределено = Ложь) Экспорт
	
	Если бит_ОбщегоНазначения.ЭтоСемействоБП() Тогда	
		
		Модуль = ОбщегоНазначения.ОбщийМодуль("ОбщегоНазначенияБПВызовСервера");
		Массив = Модуль.УдалитьПовторяющиесяЭлементыМассива(Массив, НеИспользоватьНеопределено);                
		
	ИначеЕсли бит_ОбщегоНазначения.ЭтоСемействоERP() Тогда	
		
		Модуль = ОбщегоНазначения.ОбщийМодуль("ОбщегоНазначенияУТ");
		Массив = Модуль.УдалитьПовторяющиесяЭлементыМассива(Массив, НеИспользоватьНеопределено);                
		
	КонецЕсли; 
	
	Возврат Массив;
	
КонецФункции // УдалитьПовторяющиесяЭлементыМассива()	

// Устарела. Следует использовать ОбщегоНазначенияКлиентСервер.ДополнитьТаблицу().
Процедура ЗагрузитьВТаблицуЗначений(ТаблицаИсточник, ТаблицаПриемник) Экспорт
	
	ОбщегоНазначенияКлиентСервер.ДополнитьТаблицу(ТаблицаИсточник, ТаблицаПриемник);
	
КонецПроцедуры

// Функция создает по структуре параметров соответсвие.
// 
// Параметры:
//  СтруктураПараметров - Структура.
// 
// Возвращаемое значение:
//  Параметры - Соответствие.
// 
Функция СоздатьПоСтруктуреСоответствие(Знач СтруктураПараметров) Экспорт
	
	Параметры = Новый Соответствие;
	
	Для Каждого Элемент Из СтруктураПараметров Цикл
		
		Параметры.Вставить(Элемент.Ключ, Элемент.Значение);
		
	КонецЦикла;
	
	Возврат Параметры;
	
КонецФункции // СоздатьПоСтруктуреСоответствие()

// Функция созданиет копии структуры или соответствия.
// 
// Параментры:
//   СоответствиеИсточник - Структура/Соответствие - Исходная структура, с которой будет создаваться копия.
// 
// Возвращаемое значение:
//   Структура/Соответствие - Копия исходной структуры. Тип данных повторяет тип исходной структуры.
// 
Функция СоздатьКопиюСоответствияСтруктуры(Знач СоответствиеИсточник) Экспорт
	
	Если СоответствиеИсточник = Неопределено Тогда		
		Возврат Неопределено; 		
	КонецЕсли;
	
	КопияСоответствия = Новый (ТипЗнч(СоответствиеИсточник));
		
	Для Каждого ЭлементОтбора Из СоответствиеИсточник Цикл   				
		КопияСоответствия.Вставить(ЭлементОтбора.Ключ, ЭлементОтбора.Значение);  				
	КонецЦикла;
	
	Возврат КопияСоответствия;
	
КонецФункции // СоздатьКопиюСоответствияСтруктуры()

#КонецОбласти

