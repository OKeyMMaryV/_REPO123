////////////////////////////////////////////////////////////////////////////////
// Подсистема "Базовая функциональность в модели сервиса".
// Серверные процедуры и функции общего назначения:
// - Поддержка работы в модели сервиса.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Возвращает конечную точку для отправки сообщений в менеджер сервиса.
//
// Возвращаемое значение:
//  ПланОбменСсылка.ОбменСообщениями - узел соответствующий менеджеру сервиса.
//
Функция КонечнаяТочкаМенеджераСервиса() Экспорт
	
	Возврат РаботаВМоделиСервисаБТС.КонечнаяТочкаМенеджераСервиса();
	
КонецФункции

// см. функцию РаботаВМоделиСервисаБТС.СоединениеСМенеджеромСервиса.
//
Функция СоединениеСМенеджеромСервиса(ДанныеСервера, Таймаут = 60) Экспорт
	
	Возврат РаботаВМоделиСервисаБТС.СоединениеСМенеджеромСервиса(ДанныеСервера, Таймаут);
	
КонецФункции
 
#КонецОбласти
