////////////////////////////////////////////////////////////////////////////////
// Модуль содержит реализацию методов работы с метаданными конфигурации.
//  
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс
	
// Позволяет определить есть ли среди реквизитов объекта
// реквизит с переданным именем.
// 
// Параметры:
//  ИмяРеквизита - строковое имя искомого реквизита.
//  МетаОбъект - объект описания метаданных, среди реквизитов которого производится поиск.
// 
// Возвращаемое значение:
//  Истина - нашли реквизит с таким именем, Ложь - не нашли.
// 
Функция ЕстьРеквизит(ИмяРеквизита, МетаОбъект) Экспорт

	Возврат НЕ (МетаОбъект.Реквизиты.Найти(ИмяРеквизита) = Неопределено);

КонецФункции // ЕстьРеквизит()

// Позволяет определить есть ли среди стандартных реквизитов объекта
// реквизит с переданным именем.
// 
// Параметры:
//  ИмяРеквизита - строковое имя искомого реквизита.
//  МетаОбъект - объект описания метаданных, среди реквизитов которого производится поиск.
// 
// Возвращаемое значение:
//  Истина - нашли реквизит с таким именем, Ложь - не нашли.
// 
Функция ЕстьСтандартныйРеквизит(ИмяРеквизита, МетаОбъект) Экспорт

	флЕсть = Ложь;
	Для каждого МетаРеквизит Из МетаОбъект.СтандартныеРеквизиты Цикл
	
		Если МетаРеквизит.Имя = ИмяРеквизита Тогда
			
			 флЕсть = Истина;
			 Продолжить;
		
		КонецЕсли; 
	
	КонецЦикла; 
	
	Возврат флЕсть;

КонецФункции // ЕстьРеквизит()

// Позволяет определить есть ли табличная часть объекта с переданным именем.
// 
// Параметры:
//  ИмяТабЧасти - строковое имя искомой табличной части.
//  МетаОбъект  - объект описания метаданных, среди реквизитов которого производится поиск.
// 
// Возвращаемое значение:
//  Истина - нашли реквизит с таким именем, Ложь - не нашли.
// 
Функция ЕстьТабЧасть(ИмяТабЧасти, МетаОбъект) Экспорт

	Если МетаОбъект.ТабличныеЧасти.Найти(ИмяТабЧасти) = Неопределено Тогда
		Возврат Ложь;
	Иначе
		Возврат Истина;
	КонецЕсли;

КонецФункции // ЕстьТабЧасть()

// Позволяет определить есть ли среди реквизитов табличной части документа
// реквизит с переданным именем.
// 
// Параметры:
//  ИмяРеквизита - строковое имя искомого реквизита.
//  МетаОбъект   - объект описания метаданных, среди реквизитов которого производится поиск.
//  ИмяТабЧасти  - строковое имя табличной части объекта, среди реквизитов которого производится поиск.
// 
// Возвращаемое значение:
//  Истина - нашли реквизит с таким именем, Ложь - не нашли.
// 
Функция ЕстьРеквизитТабЧасти(ИмяРеквизита, МетаОбъект, ИмяТабЧасти) Экспорт

	ТабЧасть = МетаОбъект.ТабличныеЧасти.Найти(ИмяТабЧасти);

	Если ТабЧасть = Неопределено Тогда // Нет такой таб. части в документе
		Возврат Ложь;

	Иначе
		Возврат НЕ (ТабЧасть.Реквизиты.Найти(ИмяРеквизита) = Неопределено);

	КонецЕсли;

КонецФункции // ЕстьРеквизитТабЧастиДокумента()

// Позволяет определить составной ли тип у реквизита.
// 
// Параметры:
//  ИмяРеквизита - Строка 
//  МетаОбъект   - Объект описания метаданных, среди реквизитов которого производится поиск.
//  ИмяТабЧасти  - Строка.
// 
// Возвращаемое значение:
//  Булево - тип составной 
// 
Функция ЭтотРеквизитСоставногоТипа(ИмяРеквизита, МетаОбъект, ИмяТабЧасти = "") Экспорт

    Если ЗначениеЗаполнено(ИмяТабЧасти) Тогда
        
        ТекРеквизит = МетаОбъект.ТабличныеЧасти[ИмяТабЧасти].Реквизиты[ИмяРеквизита]; 	
    
    Иначе
        
        ТекРеквизит  = МетаОбъект.Реквизиты[ИмяРеквизита];
  
    КонецЕсли;
    
    Возврат ТекРеквизит.Тип.Типы().Количество() > 1;
	
КонецФункции // ЭтотРеквизитСоставногоТипа()  

// Функция определяет принадлежит объект указанной коллекции метаданных или нет.
// 
// Параметры:
//  ИмяКоллекции  - Строка
//  ИмяОбъекта    - Строка
// 
// Возвращаемое значение:
//   флПринадлежит   - Булево
// 
Функция ОбъектПринадлежитКоллекцииМетаданных(ИмяКоллекции,ИмяОбъекта) Экспорт

	Если Метаданные[ИмяКоллекции].Найти(ИмяОбъекта) = НЕОПРЕДЕЛЕНО Тогда
		флПринадлежит = Ложь;
	Иначе	
		флПринадлежит = Истина;
	КонецЕсли; 
	
	Возврат флПринадлежит;

КонецФункции // ОбъектПринадлежитКоллекцииМетаданных()

// Проверяет правильность заполнения шапки документа.
// Если какой-то из реквизитов шапки не заполнен или
// заполнен не корректно, то выставляется флаг отказа.
// 
// Параметры: 
//  ДокументОбъект             - объект документа. 
//  СтруктураОбязательныхПолей - структура, содержащая имена полей, которые собственно и надо проверить.
//  Отказ                      - флаг отказа в проведении.
//  Заголовок                  - строка, заголовок сообщения об ошибке проведения.
// 
Процедура ПроверитьЗаполнениеШапки(ТекОбъект, СтруктураОбязательныхПолей, Отказ, Заголовок = "") Экспорт
	
	ТипыПланыСчетов     = ПланыСчетов.ТипВсеСсылки();
	МетаданныеРеквизиты = ТекОбъект.Метаданные().Реквизиты;

	Для каждого КлючЗначение Из СтруктураОбязательныхПолей Цикл

		Значение = ТекОбъект[КлючЗначение.Ключ];
		ПредставлениеРеквизита = МетаданныеРеквизиты[КлючЗначение.Ключ].Представление();

		Если НЕ ЗначениеЗаполнено(Значение) Тогда 

			Если НЕ ЗначениеЗаполнено(КлючЗначение.Значение) Тогда // 
				СтрокаСообщения = НСтр("ru='Не заполнено значение реквизита %1%!'");
				СтрокаСообщения = бит_ОбщегоНазначенияКлиентСервер.ПодставитьПараметрыСтроки(СтрокаСообщения, СокрЛП(ПредставлениеРеквизита));
			Иначе
				СтрокаСообщения = КлючЗначение.Значение;
			КонецЕсли;

			бит_ОбщегоНазначенияКлиентСервер.ВывестиСообщение(СтрокаСообщения,ТекОбъект,КлючЗначение.Ключ,Отказ);

		ИначеЕсли ТипыПланыСчетов.СодержитТип(ТипЗнч(Значение)) тогда

            СвСч = бит_БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Значение);
			Если СвСч.ЗапретитьИспользоватьВПроводках Тогда
				СтрокаСообщения = НСтр("ru='Реквизит ""%1%"" : счет %2% ""%3%"" нельзя использовать в проводках.'");
				СтрокаСообщения = бит_ОбщегоНазначенияКлиентСервер.ПодставитьПараметрыСтроки(СтрокаСообщения, СокрЛП(ПредставлениеРеквизита), СокрЛП(Значение), Значение.Наименование);
				
				бит_ОбщегоНазначенияКлиентСервер.ВывестиСообщение(СтрокаСообщения,ТекОбъект,КлючЗначение.Ключ,Отказ);

			КонецЕсли;

		КонецЕсли;

	КонецЦикла;
	
	бит_ОбщегоНазначения.ПроверитьЗаполнениеШапкиДокумента(ТекОбъект, СтруктураОбязательныхПолей, Отказ);
	
КонецПроцедуры // ПроверитьЗаполнениеШапки()	

// Процедура проверяет заполнение табличной части объекта.
// 
// Параметры:
//  ТекОбъект                  - ДокументОбъект, СправочникОбъект.
//  ИмяТабличнойЧасти          - Строка.
//  СтруктураОбязательныхПолей - Структура.
//  Отказ                      - Булево.
//  Заголовок                  - Строка.
// 
Процедура ПроверитьЗаполнениеТабличнойЧасти(ТекОбъект
	                                         , ИмяТабличнойЧасти
											 , СтруктураОбязательныхПолей
											 , Отказ
											 , Заголовок = "") Экспорт

	ПредставлениеТабличнойЧасти = ТекОбъект.Метаданные().ТабличныеЧасти[ИмяТабличнойЧасти].Представление();

	ТабличнаяЧасть      = ТекОбъект[ИмяТабличнойЧасти];
	МетаданныеРеквизиты = ТекОбъект.Метаданные().ТабличныеЧасти[ИмяТабличнойЧасти].Реквизиты;
	
	ПроверятьВидДеятельности = (МетаданныеРеквизиты.Найти("СчетДоходов") <> Неопределено)
		И (МетаданныеРеквизиты.Найти("СчетРасходов") <> Неопределено);
	
	КэшСчетов = Новый Соответствие;
	
	// Цикл по строкам табличной части.
	Для каждого СтрокаТаблицы Из ТабличнаяЧасть Цикл

        СтрокаНачалаСообщенияОбОшибке =  НСтр("ru = 'Строка номер %1% табличной части ""%2%"": '");									   
		СтрокаНачалаСообщенияОбОшибке = бит_ОбщегоНазначенияКлиентСервер.ПодставитьПараметрыСтроки(СтрокаНачалаСообщенияОбОшибке
		                                                                                                , СокрЛП(СтрокаТаблицы.НомерСтроки)
																										, ПредставлениеТабличнойЧасти);
									   
		// Цикл по проверяемым полям
		Для каждого КлючЗначение Из СтруктураОбязательныхПолей Цикл

			Значение = СтрокаТаблицы[КлючЗначение.Ключ];
			Если НЕ ЗначениеЗаполнено(Значение) Тогда 

				Если НЕ ЗначениеЗаполнено(КлючЗначение.Значение) Тогда // 
					
					ПредставлениеРеквизита = МетаданныеРеквизиты[КлючЗначение.Ключ].Представление();
					СтрокаСообщения =  НСтр("ru = 'Не заполнено значение реквизита ""%1%"".'");
					СтрокаСообщения = бит_ОбщегоНазначенияКлиентСервер.ПодставитьПараметрыСтроки(СтрокаСообщения, СокрЛП(ПредставлениеРеквизита)); 

				Иначе
					СтрокаСообщения = КлючЗначение.Значение;

				КонецЕсли;

				ТекстСообщения = СтрокаНачалаСообщенияОбОшибке + СтрокаСообщения;
				Отказ = Истина;
				бит_ОбщегоНазначенияКлиентСервер.ВывестиСообщение(ТекстСообщения);

			КонецЕсли;

		КонецЦикла;

	КонецЦикла;

КонецПроцедуры // ПроверитьЗаполнениеТабличнойЧасти()
  
// Определяет является ли справочник иерархией элементов.
// 
// Параметры:
//  МетаОбъект - ОбъектМетаданных.
// 
// Возвращаемое значение:
//  флЭтоИерархияЭлементов - Булево.
// 
Функция ЭтоИерархияЭлементов(МетаОбъект) Экспорт
	
	Если МетаОбъект.Иерархический Тогда
		флЭтоИерархияЭлементов  = ?(МетаОбъект.ВидИерархии=Метаданные.СвойстваОбъектов.ВидИерархии.ИерархияЭлементов,Истина,Ложь);
	Иначе	
		флЭтоИерархияЭлементов  = Истина;
	КонецЕсли; 
	
	Возврат флЭтоИерархияЭлементов;
	
КонецФункции // ЭтоИерархияЭлементов()

//  Получает имя значения перечисления по ссылке.
// 
// Параметры:
//  ТекПеречисление       - ПеречислениеМенеджер.
//  ЗначениеПеречисления  - ПеречислениеСсылка.
//  ИмяПоУмолчанию        - Строка.
// 
// Возвращаемое значение:
//  ИмяЗначения   - Строка
// 
Функция ПолучитьИмяЗначенияПеречисления(ТекПеречисление,ЗначениеПеречисления, ИмяПоУмолчанию = "") Экспорт
	
	ИмяЗначения = "";
	
	Если ЗначениеЗаполнено(ЗначениеПеречисления) Тогда
		
		ТекИндекс   = ТекПеречисление.Индекс(ЗначениеПеречисления);
		ИмяЗначения = ЗначениеПеречисления.Метаданные().ЗначенияПеречисления[ТекИндекс].Имя;
		
	Иначе
		
		ИмяЗначения = ИмяПоУмолчанию;
		
	КонецЕсли; 
	
	Возврат ИмяЗначения;
	
КонецФункции // бит_ПолучитьИмяПоЗначениюПеречисления()

// Функция выполняет поиск предопределенного элемента по имени.
// 
// Параметры:
//  ИмяПредопределенногоПолное - Строка в формате ИмяКласса.ИмяОбъекта.ИмяПредопределенного.
// 
// Возвращаемое значение:
//  НайденныйЭлемент - ЛюбаяСсылка, Неопределено.
// 
Функция ПолучитьПредопределенныйЭлемент(ИмяПредопределенногоПолное) Экспорт

	НайденныйЭлемент = Неопределено;
	
	Имена = бит_СтрокиКлиентСервер.РазобратьСтрокуСРазделителями(ИмяПредопределенногоПолное,".");
	ИмяПредопределенного = Имена[2];
	ИмяОбъекта = Имена[1];
	ИмяКласса = Имена[0];
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ТекТаб.Ссылка
	               |ИЗ
	               |	%ИмяКласса%.%ИмяОбъекта% КАК ТекТаб
	               |ГДЕ
	               |	ТекТаб.Предопределенный = ИСТИНА";
				   
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "%ИмяКласса%", ИмяКласса);
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "%ИмяОбъекта%", ИмяОбъекта);
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Если Выборка.Ссылка.ИмяПредопределенныхДанных = ИмяПредопределенного Тогда
		
		     НайденныйЭлемент = Выборка.Ссылка;
			 Прервать;
		
		КонецЕсли; 
	
	КонецЦикла; 

	Возврат НайденныйЭлемент;
	
КонецФункции // ПолучитьПредопределенныйЭлемент()

// Функция определяет есть предопределенный с таким именем или нет.
// 
// Параметры:
//  ИмяПредопределенногоПолное - Строка в формате ИмяКласса.ИмяОбъекта.ИмяПредопределенного.
// 
// Возвращаемое значение:
//  НайденныйЭлемент - ЛюбаяСсылка, Неопределено.
// 
Функция ЕстьПредопределенныйЭлемент(ИмяПредопределенногоПолное) Экспорт

	флЕсть = Ложь;
	
	НайденныйЭлемент = ПолучитьПредопределенныйЭлемент(ИмяПредопределенногоПолное);
	
	флЕсть = ?(ЗначениеЗаполнено(НайденныйЭлемент), Истина, Ложь);

	Возврат флЕсть;
	
КонецФункции // ЕстьПредопределенныйЭлемент()

// Функция проверяет есть ли такое перечисление в текущей конфигурации.
// 
// Параметры:
//  ИмяСправочника - строка
// 
// Возвращаемое значение:
//  булево.
// 
Функция ЕстьПеречисление(ИмяПеречисления) Экспорт 

	Если Метаданные.Перечисления.Найти(ИмяПеречисления) <> Неопределено Тогда
	
		Возврат Истина;
	
	КонецЕсли; 
	
	Возврат Ложь;
	
КонецФункции // ЕстьПеречисление()

// Функция проверяет есть ли такой справочник в текущей конфигурации.
// 
// Параметры:
//  ИмяСправочника - строка
// 
// Возвращаемое значение:
//  булево.
// 
Функция ЕстьСправочник(ИмяСправочника) Экспорт 

	Если Метаданные.Справочники.Найти(ИмяСправочника) <> Неопределено Тогда
	
		Возврат Истина;
	
	КонецЕсли; 
	
	Возврат Ложь;
	
КонецФункции // ЕстьСправочник()

// Функция проверяет есть ли такой документ в текущей конфигурации.
// 
// Параметры:
//  ИмяДокумента - строка
// 
// Возвращаемое значение:
//  булево.
// 
Функция ЕстьДокумент(ИмяДокумента) Экспорт 

	Если Метаданные.Документы.Найти(ИмяДокумента) <> Неопределено Тогда
	
		Возврат Истина;
	
	КонецЕсли; 
	
	Возврат Ложь;
	
КонецФункции // ЕстьДокумент()

// Функция проверяет есть ли регистр бухгалтерии в текущей конфигурации.
// 
// Параметры:
//  ИмяОбъекта - строка
// 
// Возвращаемое значение:
//  булево.
// 
Функция ЕстьРегистрБухгалтерии(ИмяОбъекта) Экспорт 

	Если Метаданные.РегистрыБухгалтерии.Найти(ИмяОбъекта) <> Неопределено Тогда
	
		Возврат Истина;
	
	КонецЕсли; 
	
	Возврат Ложь;
	
КонецФункции // ЕстьРегистрБухгалтерии()

// Функция проверяет есть ли регистр накопления в текущей конфигурации.
// 
// Параметры:
//  ИмяОбъекта - строка
// 
// Возвращаемое значение:
//  булево.
// 
Функция ЕстьРегистрНакопления(ИмяОбъекта) Экспорт 

	Если Метаданные.РегистрыНакопления.Найти(ИмяОбъекта) <> Неопределено Тогда
	
		Возврат Истина;
	
	КонецЕсли; 
	
	Возврат Ложь;
	
КонецФункции // ЕстьРегистрБухгалтерии()

// Функция определяет имя объекта ссылочного типа по описанию типов.
// 
// Параметры:
//  ОписаниеТипов - ОписаниеТипов- содержит тип, имя объекта которого нужно определить.
// 
// Возвращаемое значение:
//  РезСтруктура  - Структура (Ключи: "Имя","Синоним","ИмяТипа"; Значения: Строка) 
//                   Неопределено (если имя не удалось определить). 
// 
Функция ПолучитьИмяОбъектаПоОписаниюТипов(ОписаниеТипов) Экспорт
	 
    РезСтруктура = Новый Структура("Имя, Синоним, ИмяТипа", "", "", "");

    МассивТипов = ОписаниеТипов.Типы();

    Если МассивТипов.Количество() > 0 Тогда

        ТекТип = МассивТипов[0];

        МетаОбъект = Метаданные.НайтиПоТипу(ТекТип);

        Если НЕ МетаОбъект = Неопределено Тогда

            Имена = бит_ОбщегоНазначенияКлиентСервер.РазобратьПолноеИмяОбъекта(МетаОбъект.ПолноеИмя());
            ИмяТипа = Имена.ИмяКласса + "Ссылка." + МетаОбъект.Имя;
            РезСтруктура = Новый Структура;
            РезСтруктура.Вставить("Имя"    , МетаОбъект.Имя);
            РезСтруктура.Вставить("Синоним", МетаОбъект.Синоним);
            РезСтруктура.Вставить("ИмяТипа", ИмяТипа);

        КонецЕсли; 

    КонецЕсли; 

    Возврат РезСтруктура;
	 
КонецФункции // ПолучитьИмяОбъектаПоОписаниюТипов()

#КонецОбласти
