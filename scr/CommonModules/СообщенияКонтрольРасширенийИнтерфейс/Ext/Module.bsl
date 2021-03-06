
#Область ПрограммныйИнтерфейс

// Возвращает пространство имен текущей (используемой вызывающим кодом) версии интерфейса сообщений.
Функция Пакет() Экспорт
	
	Возврат "http://www.1c.ru/1cFresh/ConfigurationExtensions/Control/" + Версия();
	
КонецФункции

// Возвращает текущую (используемую вызывающим кодом) версию интерфейса сообщений
Функция Версия() Экспорт
	
	Возврат "1.0.0.1";
	
КонецФункции

// Возвращает название программного интерфейса сообщений
Функция ПрограммныйИнтерфейс() Экспорт
	
	Возврат "ConfigurationExtensionsControl";
	
КонецФункции

// Выполняет регистрацию обработчиков сообщений в качестве обработчиков каналов обмена сообщениями.
//
//	Параметры:
//  	МассивОбработчиков - Массив - массив обработчиков
//
//@skip-warning Пустой метод
Процедура ОбработчикиКаналовСообщений(Знач МассивОбработчиков) Экспорт

КонецПроцедуры

// Выполняет регистрацию обработчиков трансляции сообщений.
//
//	Параметры:
//		МассивОбработчиков - Массив - массив обработчиков
//
//@skip-warning Пустой метод
Процедура ОбработчикиТрансляцииСообщений(Знач МассивОбработчиков) Экспорт
	
КонецПроцедуры

// Возвращает тип сообщения {http://www.1c.ru/1cFresh/ConfigurationExtensions/Control/a.b.c.d}Installed
//
//	Параметры:
//		ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    		получается тип сообщения.
//
//	Возвращаемое значение:
//		ОбъектXDTO - тип XDTO сообщения Installed
//
Функция СообщениеРасширениеУстановлено(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "Installed");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/1cFresh/ConfigurationExtensions/Control/a.b.c.d}Deleted
//
//	Параметры:
//		ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    		получается тип сообщения.
//
//	Возвращаемое значение:
//		ОбъектXDTO - тип XDTO сообщения Deleted
//
Функция СообщениеРасширениеУдалено(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "Deleted");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/1cFresh/ConfigurationExtensions/Control/a.b.c.d}InstallFailed
//
//	Параметры:
//		ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//			получается тип сообщения.
//
//	Возвращаемое значение:
//		ОбъектXDTO - тип XDTO сообщения InstallFailed
//
Функция СообщениеОшибкаУстановкиРасширения(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "InstallFailed");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/1cFresh/ConfigurationExtensions/Control/a.b.c.d}Failed
//
//	Параметры:
//   ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой получается тип сообщения.
//
//	Возвращаемое значение:
//	 ОбъектXDTO - тип XDTO сообщения DeleteFailed
//
Функция СообщениеОшибкаУдаленияРасширения(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "Failed");
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция СоздатьТипСообщения(Знач ИспользуемыйПакет, Знач Тип)
	
	Если ИспользуемыйПакет = Неопределено Тогда
		
		ИспользуемыйПакет = Пакет();
		
	КонецЕсли;
	
	Возврат ФабрикаXDTO.Тип(ИспользуемыйПакет, Тип);
	
КонецФункции

#КонецОбласти
