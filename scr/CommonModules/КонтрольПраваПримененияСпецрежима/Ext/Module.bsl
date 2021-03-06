#Область ПрограммныйИнтерфейс

// Возвращает структуру, с информацией о праве применения спецрежима
// по показателю.
//
// Параметры:
//  Организация - Справочник.Организация - Организация, для которой получаем информацию
//  ИмяПоказателя - Строка - см. процедуры ИмяПоказателяСпецрежимаДоходы() и прочие
//
// Возвращаемое значение:
//  Структура - см. НовыйИнформацияОПравеПримененияСпецрежима()
//
Функция ИнформацияОПравеПримененияСпецрежима(Организация, ИмяПоказателя) Экспорт
	
	ДатаПроверки      = ОбщегоНазначения.ТекущаяДатаПользователя();
	ПрименяетсяУСН    = УчетнаяПолитика.ПрименяетсяУСН(Организация, ДатаПроверки);
	ПрименяетсяПатент = УчетнаяПолитика.ПрименяетсяУСНПатент(Организация, ДатаПроверки);
	
	// Если это не спецрежим, тогда не показываем информацию
	Если НЕ (ПрименяетсяУСН ИЛИ ПрименяетсяПатент) Тогда
		Возврат НовыйИнформацияОПравеПримененияСпецрежима();
	КонецЕсли;
	
	ИнформацияПоПоказателю = ИнформацияПоПоказателю(ИмяПоказателя, Организация, ДатаПроверки);
	
	Если НЕ ДостигнутоСледующееЗначениеНапоминания(ИмяПоказателя, ИнформацияПоПоказателю, Организация, ДатаПроверки) Тогда
		Возврат НовыйИнформацияОПравеПримененияСпецрежима();
	КонецЕсли;
	
	ИнформацияОПравеПримененияСпецрежима = НовыйИнформацияОПравеПримененияСпецрежима();
	ИнформацияОПравеПримененияСпецрежима.УтраченоПравоПрименения      = ИнформацияПоПоказателю.УтраченоПравоПрименения;
	ИнформацияОПравеПримененияСпецрежима.Показать                     = Истина;
	ИнформацияОПравеПримененияСпецрежима.СледующееЗначениеНапоминания = СледующееЗначениеНапоминания(ИнформацияПоПоказателю.Процент);
	ИнформацияОПравеПримененияСпецрежима.СсылкаНаСтатьюИТС = СсылкаНаСтатьюИТСПоПравуПримененияСпецрежима(
		ПрименяетсяПатент,
		ИнформацияОПравеПримененияСпецрежима.УтраченоПравоПрименения,
		ИмяПоказателя);
	ИнформацияОПравеПримененияСпецрежима.ТекстИнформации = ТекстИнформацияОПоказателе(
		ИнформацияПоПоказателю,
		ИмяПоказателя,
		ПрименяетсяПатент);
	ИнформацияОПравеПримененияСпецрежима.ТекстНапомнитьПозже = СтрШаблон(
		НСтр("ru='Напомнить при %1'"),
		Строка(ИнформацияОПравеПримененияСпецрежима.СледующееЗначениеНапоминания) + "%");
	Если ИнформацияОПравеПримененияСпецрежима.УтраченоПравоПрименения Тогда
		ИнформацияОПравеПримененияСпецрежима.ЦветФонаГруппы = ЦветаСтиля.ЦветФонаНекорректногоКонтрагентаВДокументе;
	КонецЕсли;
	
	Возврат ИнформацияОПравеПримененияСпецрежима;
	
КонецФункции

// Откладывает показ напоминание по показателю
//
// Параметры:
//  Организация - Справочник.Организация - Организация, для которой получаем информацию
//  ИмяПоказателя - Строка - см. процедуры ИмяПоказателяСпецрежимаДоходы() и прочие
//  СледующееЗначениеНапоминания - Число - Процент, при котором в следующий раз будет показана информация
//
Процедура ОтложитьПоказНапоминания(Организация, ИмяПоказателя, СледующееЗначениеНапоминания) Экспорт

	ИмяНастройкиПоказателя = ИмяНастройкиПравоПримененияСпецрежима() + ИмяПоказателя;
	
	// Получим ранее сохраненные данные
	СледующееНапоминание = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
		ИмяНастройкиПравоПримененияСпецрежима(), 
		ИмяНастройкиПоказателя);
		
	// Если их нет, то создадим новое соответствие
	Если СледующееНапоминание = Неопределено Тогда
		СледующееНапоминание = Новый Соответствие;
	КонецЕсли;
	
	// Процент не должен быть больше 90%
	СледующееЗначениеНапоминания = Мин(СледующееЗначениеНапоминания, 90);
	ПериодНапоминания = Год(ОбщегоНазначения.ТекущаяДатаПользователя());
	
	// Получим соответствие по организациям
	НапоминаниеПоОрганизации = СледующееНапоминание[Организация];
	Если НапоминаниеПоОрганизации = Неопределено Тогда
		НапоминаниеПоДате = Новый Соответствие;
		НапоминаниеПоДате.Вставить(ПериодНапоминания, СледующееЗначениеНапоминания);
		СледующееНапоминание.Вставить(Организация, НапоминаниеПоДате);
	Иначе
		НапоминаниеПоОрганизации.Вставить(ПериодНапоминания, СледующееЗначениеНапоминания);
	КонецЕсли;
	
	// Сохраним новые настройки
	ОбщегоНазначения.ХранилищеОбщихНастроекСохранить(
		ИмяНастройкиПравоПримененияСпецрежима(), 
		ИмяНастройкиПоказателя,
		СледующееНапоминание);

КонецПроцедуры

#КонецОбласти

#Область ИнформацияОПравеПримененияСпецрежима

Функция НовыйИнформацияОПравеПримененияСпецрежима()

	Структура = Новый Структура;
	Структура.Вставить("Показать",                     Ложь);
	Структура.Вставить("УтраченоПравоПрименения",      Ложь);
	Структура.Вставить("ТекстИнформации",              "");
	Структура.Вставить("СсылкаНаСтатьюИТС",            "");
	Структура.Вставить("СледующееЗначениеНапоминания", 50);
	Структура.Вставить("ТекстНапомнитьПозже",          "");
	Структура.Вставить("ЦветФонаГруппы",               ЦветаСтиля.БыстрыеОтборыФонГруппы);
	
	Возврат Структура;

КонецФункции

Функция ИнформацияПоПоказателю(ИмяПоказателя, Организация, ДатаПроверки)
	
	ИнформацияПоПоказателю = НовыйИнформацияПоПоказателю();
	
	ДоступныеОрганизации = ОбщегоНазначенияБПВызовСервераПовтИсп.ВсеОрганизацииДанныеКоторыхДоступныПоRLS(Ложь);
	Если ДоступныеОрганизации.Найти(Организация) = Неопределено Тогда
		// Организация не доступна, выполнять ничего не будем.
		Возврат ИнформацияПоПоказателю;
	КонецЕсли;
	
	Если ИмяПоказателя = ИмяПоказателяСпецрежимаДоходы() Тогда
		ИнформацияПоПоказателю = ИнформацияПоПоказателюДоходы(Организация, ДатаПроверки);
	ИначеЕсли ИмяПоказателя = ИмяПоказателяСпецрежимаОсновныеСредства() Тогда
		ИнформацияПоПоказателю = ИнформацияПоПоказателюОсновныеСредства(Организация, ДатаПроверки);
	ИначеЕсли ИмяПоказателя = ИмяПоказателяСпецрежимаРаботники() Тогда
		ИнформацияПоПоказателю = ИнформацияПоПоказателюРаботники(Организация, ДатаПроверки);
	КонецЕсли;
	
	Возврат ИнформацияПоПоказателю;

КонецФункции

Функция ИнформацияПоПоказателюДоходы(Организация, ДатаПроверки)
	
	ПрименяетсяУСНПатент                    = УчетнаяПолитика.ПрименяетсяУСНПатент(Организация, ДатаПроверки);
	ПрименяетсяОсобыйПорядокНалогообложения = УчетнаяПолитика.ПрименяетсяОсобыйПорядокНалогообложения(Организация, ДатаПроверки);
	ПрименяетсяТолькоПатент                 = ПрименяетсяОсобыйПорядокНалогообложения И ПрименяетсяУСНПатент;
	ПрименяетсяУСН                          = УчетнаяПолитика.ПрименяетсяУСН(Организация, ДатаПроверки);
	
	НачалоПериода = НачалоГода(ДатаПроверки);
	
	Если ПрименяетсяУСН Тогда
		НалоговыйПериодУСН = ИнтерфейсыВзаимодействияБРО.БлижайшийНалоговыйПериод(Организация, ДатаПроверки,
			Перечисления.ВариантыРасширенногоПервогоНалоговогоПериода.РегистрацияВДекабре);
		
		Если НалоговыйПериодУСН.Начало <= ДатаПроверки Тогда
			// Доходы контролируются с начала налогового периода.
			НачалоПериода = НалоговыйПериодУСН.Начало;
		Иначе
			// Проверка на дату ранее начала первого налогового периода не имеет смысла - деятельность отсутствует.
			Возврат НовыйИнформацияПоПоказателю();
		КонецЕсли;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Организация",   Организация);
	Запрос.УстановитьПараметр("НачалоПериода", НачалоПериода);
	Запрос.УстановитьПараметр("КонецПериода",  КонецМесяца(ДатаПроверки));
	
	Если ПрименяетсяУСН И НЕ ПрименяетсяТолькоПатент Тогда
		Запрос.Текст =
		"ВЫБРАТЬ
		|	КнигаУчетаДоходовИРасходовОбороты.Графа5Оборот КАК Показатель
		|ИЗ
		|	РегистрНакопления.КнигаУчетаДоходовИРасходов.Обороты(&НачалоПериода, &КонецПериода, , Организация = &Организация) КАК КнигаУчетаДоходовИРасходовОбороты
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	КнигаУчетаДоходовПатентОбороты.Графа4Оборот
		|ИЗ
		|	РегистрНакопления.КнигаУчетаДоходовПатент.Обороты(&НачалоПериода, &КонецПериода, , Организация = &Организация) КАК КнигаУчетаДоходовПатентОбороты";
	Иначе
		Запрос.Текст =
		"ВЫБРАТЬ
		|	КнигаУчетаДоходовПатентОбороты.Графа4Оборот КАК Показатель
		|ИЗ
		|	РегистрНакопления.КнигаУчетаДоходовПатент.Обороты(&НачалоПериода, &КонецПериода, , Организация = &Организация) КАК КнигаУчетаДоходовПатентОбороты";
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	РезультатЗапроса = Запрос.Выполнить();
	УстановитьПривилегированныйРежим(Ложь);
	
	ИнформацияПоПоказателю = НовыйИнформацияПоПоказателю();
	
	Если НЕ РезультатЗапроса.Пустой() Тогда
		ТаблицаДоходов = РезультатЗапроса.Выгрузить();
		ИнформацияПоПоказателю.Показатель = ТаблицаДоходов.Итог("Показатель");
		ИнформацияПоПоказателю.Граница    = ?(ПрименяетсяУСНПатент,
			ГраницаДоходовОграничивающаяПравоПримененияПСН(),
			ГраницаДоходовОграничивающаяПравоПримененияУСН(ДатаПроверки));
		ИнформацияПоПоказателю.Процент    = Окр(ИнформацияПоПоказателю.Показатель * 100 / ИнформацияПоПоказателю.Граница, 0);
		ИнформацияПоПоказателю.УтраченоПравоПрименения = (ИнформацияПоПоказателю.Показатель > ИнформацияПоПоказателю.Граница);
		
	КонецЕсли;
	
	Возврат ИнформацияПоПоказателю;
	
КонецФункции

Функция ИнформацияПоПоказателюОсновныеСредства(Организация, ДатаПроверки)

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Организация",   Организация);
	Запрос.УстановитьПараметр("КонецПериода",  Новый Граница(КонецМесяца(ДатаПроверки), ВидГраницы.Включая));
	Запрос.УстановитьПараметр("СчетОС",
		БухгалтерскийУчетПовтИсп.СчетаВИерархии(ПланыСчетов.Хозрасчетный.ОсновныеСредства));
	Запрос.УстановитьПараметр("СчетаАмортизации",
		БухгалтерскийУчетПовтИсп.СчетаВИерархии(ПланыСчетов.Хозрасчетный.АмортизацияОсновныхСредств));
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ОсновныеСредства.Ссылка
	|ПОМЕСТИТЬ НеАмортизируемыеОС
	|ИЗ
	|	Справочник.ОсновныеСредства КАК ОсновныеСредства
	|ГДЕ
	|	ОсновныеСредства.ГруппаОС = ЗНАЧЕНИЕ(Перечисление.ГруппыОС.ЗемельныеУчастки)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЕСТЬNULL(ХозрасчетныйОстатки.СуммаОстатокДт, 0) КАК СуммаОС
	|ПОМЕСТИТЬ ОС
	|ИЗ
	|	РегистрБухгалтерии.Хозрасчетный.Остатки(
	|			&КонецПериода,
	|			Счет В (&СчетОС),
	|			ЗНАЧЕНИЕ(ПланВидовХарактеристик.ВидыСубконтоХозрасчетные.ОсновныеСредства),
	|			Организация = &Организация
	|				И НЕ Субконто1 В
	|						(ВЫБРАТЬ
	|							НеАмортизируемыеОС.Ссылка
	|						ИЗ
	|							НеАмортизируемыеОС КАК НеАмортизируемыеОС)) КАК ХозрасчетныйОстатки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЕСТЬNULL(ХозрасчетныйОстатки.СуммаОстатокКт, 0) КАК СуммаАмортизации
	|ПОМЕСТИТЬ Амортизация
	|ИЗ
	|	РегистрБухгалтерии.Хозрасчетный.Остатки(&КонецПериода, Счет В (&СчетаАмортизации), , Организация = &Организация) КАК ХозрасчетныйОстатки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ОС.СуммаОС - Амортизация.СуммаАмортизации КАК Показатель
	|ИЗ
	|	ОС КАК ОС,
	|	Амортизация КАК Амортизация";
	
	УстановитьПривилегированныйРежим(Истина);
	РезультатЗапроса = Запрос.Выполнить();
	УстановитьПривилегированныйРежим(Ложь);
	
	ИнформацияПоПоказателю = НовыйИнформацияПоПоказателю();
	
	Если НЕ РезультатЗапроса.Пустой() Тогда
		
		Выборка = РезультатЗапроса.Выбрать();
		Выборка.Следующий();
		
		ИнформацияПоПоказателю.Показатель = Выборка.Показатель;
		ИнформацияПоПоказателю.Граница    = ГраницаСтоимостиОсновныхСредствОграничивающаяПравоПримененияУСН(ДатаПроверки);
		ИнформацияПоПоказателю.Процент    = Окр(ИнформацияПоПоказателю.Показатель * 100 / ИнформацияПоПоказателю.Граница, 0);
		ИнформацияПоПоказателю.УтраченоПравоПрименения = (ИнформацияПоПоказателю.Показатель > ИнформацияПоПоказателю.Граница);
		
	КонецЕсли;
	
	Возврат ИнформацияПоПоказателю;
	
КонецФункции

Функция ИнформацияПоПоказателюРаботники(Организация, ДатаПроверки)
	
	ПрименяетсяУСН                          = УчетнаяПолитика.ПрименяетсяУСН(Организация, ДатаПроверки);
	ПрименяетсяУСНПатент                    = УчетнаяПолитика.ПрименяетсяУСНПатент(Организация, ДатаПроверки);
	ПрименяетсяОсобыйПорядокНалогообложения = УчетнаяПолитика.ПрименяетсяОсобыйПорядокНалогообложения(Организация, ДатаПроверки);
	ПрименяетсяТолькоУСНПатент              = ПрименяетсяУСНПатент И ПрименяетсяОсобыйПорядокНалогообложения;
	
	Если ПрименяетсяТолькоУСНПатент Тогда
		ГраницаЧисленностиРаботников = ГраницаСреднесписочнойЧисленностиРаботниковОграничивающаяПравоПримененияПатент();
	ИначеЕсли ПрименяетсяУСН Тогда
		ГраницаЧисленностиРаботников = ГраницаСреднесписочнойЧисленностиРаботниковОграничивающаяПравоПримененияУСН();
	Иначе
		Возврат НовыйИнформацияПоПоказателю();
	КонецЕсли;
	
	НачалоПериода = НачалоГода(ДатаПроверки);
	
	Если ПрименяетсяУСН Тогда
		НалоговыйПериодУСН = ИнтерфейсыВзаимодействияБРО.БлижайшийНалоговыйПериод(Организация, ДатаПроверки,
			Перечисления.ВариантыРасширенногоПервогоНалоговогоПериода.РегистрацияВДекабре);
		
		Если НалоговыйПериодУСН.Начало <= ДатаПроверки Тогда
			// Численность работников контролируется с начала налогового периода.
			НачалоПериода = НалоговыйПериодУСН.Начало;
		Иначе
			// Проверка на дату ранее начала первого налогового периода не имеет смысла - деятельность отсутствует.
			Возврат НовыйИнформацияПоПоказателю();
		КонецЕсли;
	КонецЕсли;
	
	СведенияОЧисленностиРаботников = КадровыйУчет.СреднесписочнаяЧисленностьРаботающих(Организация, НачалоПериода, ДатаПроверки);
	
	ИнформацияПоПоказателю = НовыйИнформацияПоПоказателю();
	ИнформацияПоПоказателю.Показатель = СведенияОЧисленностиРаботников.ЧисленностьРаботников;
	ИнформацияПоПоказателю.Граница    = ГраницаЧисленностиРаботников;
	ИнформацияПоПоказателю.Процент    = Окр(ИнформацияПоПоказателю.Показатель * 100 / ИнформацияПоПоказателю.Граница, 0);
	ИнформацияПоПоказателю.УтраченоПравоПрименения = (ИнформацияПоПоказателю.Показатель > ИнформацияПоПоказателю.Граница);
	
	Возврат ИнформацияПоПоказателю;
	
КонецФункции

Функция ТекстИнформацияОПоказателе(РезультатыПоПоказателю, ИмяПоказателя, ПрименяетсяПатент)
	
	ПараметрыТекста = Новый Структура;
	
	Если ИмяПоказателя = ИмяПоказателяСпецрежимаДоходы() Тогда
		
		Если РезультатыПоПоказателю.УтраченоПравоПрименения Тогда
			ШаблонТекста = НСтр("ru='Доходы превысили границу применения [Спецрежим] ([Показатель] при допустимых [Граница])'");
		Иначе
			ШаблонТекста = НСтр("ru='Доходы достигли [Процент] от границы применения [Спецрежим] ([Показатель] из [Граница])'");
			ПараметрыТекста.Вставить("Процент", Строка(РезультатыПоПоказателю.Процент) + "%");
		КонецЕсли;
		
		Если ПрименяетсяПатент Тогда
			ПараметрыТекста.Вставить("Спецрежим", НСтр("ru='патента'"));
		Иначе
			ПараметрыТекста.Вставить("Спецрежим", НСтр("ru='УСН'"));
		КонецЕсли;
		ЕдиницаИзмерения = НСтр("ru='млн руб'");
		ФорматнаяСтрока = "ЧДЦ=3; ЧС=6";
		
	ИначеЕсли ИмяПоказателя = ИмяПоказателяСпецрежимаОсновныеСредства() Тогда
		
		Если РезультатыПоПоказателю.УтраченоПравоПрименения Тогда
			ШаблонТекста = НСтр("ru='Стоимость основных средств превысила границу применения УСН ([Показатель] при допустимых [Граница])'");
		Иначе
			ШаблонТекста = НСтр("ru='Стоимость основных средств достигла [Процент] от границы применения УСН ([Показатель] из [Граница])'");
			ПараметрыТекста.Вставить("Процент", Строка(РезультатыПоПоказателю.Процент) + "%");
		КонецЕсли;
		ЕдиницаИзмерения = НСтр("ru='млн руб'");
		ФорматнаяСтрока = "ЧДЦ=3; ЧС=6";
		
	ИначеЕсли ИмяПоказателя = ИмяПоказателяСпецрежимаРаботники() Тогда
		
		Если РезультатыПоПоказателю.УтраченоПравоПрименения Тогда
			ШаблонТекста = НСтр("ru='Средняя численность работников превысила границу применения [Спецрежим] ([Показатель] при допустимых [Граница])'");
		Иначе
			ШаблонТекста = НСтр("ru='Средняя численность работников достигла [Процент] от границы применения [Спецрежим] ([Показатель] из [Граница])'");
			ПараметрыТекста.Вставить("Процент", Строка(РезультатыПоПоказателю.Процент) + "%");
		КонецЕсли;
		
		Если ПрименяетсяПатент Тогда
			ПараметрыТекста.Вставить("Спецрежим", НСтр("ru='патента'"));
		Иначе
			ПараметрыТекста.Вставить("Спецрежим", НСтр("ru='УСН'"));
		КонецЕсли;
		ЕдиницаИзмерения = НСтр("ru='человек'");
		ФорматнаяСтрока = "";
		
	КонецЕсли;
	
	ПараметрыТекста.Вставить("Показатель", Формат(РезультатыПоПоказателю.Показатель, ФорматнаяСтрока));
	ПараметрыТекста.Вставить("Граница",    СтрШаблон(НСтр("ru='%1 %2'"),
		Формат(РезультатыПоПоказателю.Граница, ФорматнаяСтрока),
		ЕдиницаИзмерения));
		
	ТекстИнформации = СтроковыеФункцииКлиентСервер.ВставитьПараметрыВСтроку(
		ШаблонТекста, 
		ПараметрыТекста);
	
	Возврат ТекстИнформации;

КонецФункции

Функция НовыйИнформацияПоПоказателю()

	Структура = Новый Структура;
	Структура.Вставить("Показатель", 0);
	Структура.Вставить("Процент",    0);
	Структура.Вставить("Граница",    0);
	Структура.Вставить("УтраченоПравоПрименения", Ложь);
	
	Возврат Структура;

КонецФункции

#КонецОбласти

#Область Напоминания

// Получим процент, при котором следующий раз покажем предупреждение пользователю
//
Функция СледующееЗначениеНапоминания(ТекущееЗначение)
	
	// Определяется шкала показа предупреждений
	Если ТекущееЗначение < 60 Тогда
		Возврат 60;
	ИначеЕсли ТекущееЗначение < 70 Тогда
		Возврат 70;
	ИначеЕсли ТекущееЗначение < 80 Тогда
		Возврат 80;
	ИначеЕсли ТекущееЗначение < 90 Тогда
		Возврат 90;
	Иначе
		Возврат 100;
	КонецЕсли;

КонецФункции

Функция ДостигнутоСледующееЗначениеНапоминания(ИмяПоказателя, ИнформацияПоПоказателю, Организация, ДатаПроверки)

	Если ИнформацияПоПоказателю.Процент < 50 Тогда 
		Возврат Ложь;
	КонецЕсли;
	
	ИмяНастройкиПоказателя = ИмяНастройкиПравоПримененияСпецрежима() + ИмяПоказателя;
	
	СледующееНапоминание = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
		ИмяНастройкиПравоПримененияСпецрежима(), 
		ИмяНастройкиПоказателя);
	
	Если СледующееНапоминание = Неопределено Тогда
		Возврат Истина;
	КонецЕсли;
	
	НапоминаниеПоОрганизации = СледующееНапоминание[Организация];
	Если НапоминаниеПоОрганизации = Неопределено Тогда
		Возврат Истина;
	КонецЕсли;
	
	СледующееЗначениеНапоминания = НапоминаниеПоОрганизации[Год(ДатаПроверки)];
	Если СледующееЗначениеНапоминания = Неопределено Тогда
		Возврат Истина;
	КонецЕсли;
	
	Если СледующееЗначениеНапоминания <= ИнформацияПоПоказателю.Процент Тогда
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#Область НормативноСправочнаяИнформацияПоПравуПримененияСпецрежима

// Возвращает лимит доходов налогоплательщика, ограничивающий его право на применение УСН
// с учетом коэффициента дефлятора для указанной даты
// 
// Параметры:
//  Дата - Дата - Дата, на которую получаем границу.
//
// Возвращаемое значение:
//  Число - Число - Граница доходов, ограничивающая право применения УСН 
//
Функция ГраницаДоходовОграничивающаяПравоПримененияУСН(Дата) Экспорт

	БазовыйЛимитДоходов = БазовыйЛимитДоходовДляПримененияУСН(Дата);
	
	// Коэффициент ежегодной индексации базовой величины предельного дохода
	КоэффициентДефлятор = 1;
	
	Если Год(Дата) = 2014 Тогда
		КоэффициентДефлятор = 1.067; // приказ Минэкономразвития России от 07.11.2013 № 652
	ИначеЕсли Год(Дата) = 2015 Тогда
		КоэффициентДефлятор = 1.147; // приказ Минэкономразвития России от 29.10.2014 № 685
	ИначеЕсли Год(Дата) = 2016 Тогда
		КоэффициентДефлятор = 1.329; // Приказ Минэкономразвития России от 20.10.2015 № 772
	ИначеЕсли Год(Дата) >= 2017 Тогда
		КоэффициентДефлятор = 1;     // Федеральный закон от 03.07.2016 N 243-ФЗ
	КонецЕсли;
	
	Возврат БазовыйЛимитДоходов * КоэффициентДефлятор;
	
КонецФункции

// Возвращает базовый лимит доходов налогоплательщика для применения УСН,
// действующий на указанную дату, без учета коэффициента-дефлятора
//
// Параметры:
//  Дата - Дата - Дата, на которую получаем базовый лимит.
//
// Возвращаемое значение:
//  Число - Число - Лимит доходов, законодательно установленный для применения УСН
//
Функция БазовыйЛимитДоходовДляПримененияУСН(Дата) Экспорт

	// Лимит доходов налогоплательщика, ограничивающий его право на применение УСН
	// п. 4 ст. 346.13 НК РФ
	БазовыйЛимит = 60000000; // в редакции Федерального закона от 25.06.2012 N 94-ФЗ
	
	Если Год(Дата) >= 2017 Тогда
		БазовыйЛимит = 150000000; // в редакции Федерального закона от 30.11.2016 № 401-ФЗ
	КонецЕсли;
	
	Возврат БазовыйЛимит;

КонецФункции

// Возвращает сведения о применении на указанную дату коэффициента-дефлятора
// для индексации базового лимита доходов, ограничивающих право применения УСН
//
// Параметры:
//  Дата - Дата - Дата, на которую получаем сведения об использовании дефлятора.
//
// Возвращаемое значение:
//  Булево - Булево - Если Истина, то коэффициент-дефлятор применяется
//
Функция ИспользуетсяКоэффициентДефляторУСН(Дата) Экспорт

	Возврат Год(Дата) < 2017;

КонецФункции

// Возвращает лимит доходов налогоплательщика, ограничивающий его право на применение патентной системы налогообложения
//
// Возвращаемое значение:
//  Число - Число - Граница доходов, ограничивающая право применения ПСН
//
Функция ГраницаДоходовОграничивающаяПравоПримененияПСН() Экспорт

	// Лимит доходов налогоплательщика, ограничивающий его право на применение ПСН
	// пп. 1 п. 6 ст. 346.45 НК РФ
	Возврат 60000000;

КонецФункции

// Возвращает лимит доходов налогоплательщика, ограничивающий его право на применение УСН
// с учетом коэффициента дефлятора для указанной даты
// 
// Возвращаемое значение:
//  Число - Число - Граница стоимости основных средств, ограничивающая право применения УСН 
//
Функция ГраницаСтоимостиОсновныхСредствОграничивающаяПравоПримененияУСН(Дата) Экспорт

	// Лимит остаточной стоимости основных средств, определяемой по правилам бухгалтерского учета.
	// См. пп. 16 п. 3 ст. 346.12 НК РФ
	ПредельнаяСтоимостьОС = 100000000;
	
	Если Год(Дата) >= 2017 Тогда
		ПредельнаяСтоимостьОС = 150000000; // Федеральный закон от 03.07.2016 N 243-ФЗ
	КонецЕсли;
	
	Возврат ПредельнаяСтоимостьОС;
	
КонецФункции

// Возвращает лимит средней численности работников
//
// Возвращаемое значение:
//  Число - Число - Граница среднесписочной численности работников, ограничивающая право применения УСН 
//
Функция ГраницаСреднесписочнойЧисленностиРаботниковОграничивающаяПравоПримененияУСН() Экспорт
	
	// Лимит средней численности работников за налоговый период.
	// см пп. 15 п. 3 ст. 346.12 НК РФ.
	Возврат 100;
	
КонецФункции

// Возвращает лимит средней численности работников
//
// Возвращаемое значение:
//  Число - Число - Граница среднесписочной численности работников, ограничивающая право применения патента 
//
Функция ГраницаСреднесписочнойЧисленностиРаботниковОграничивающаяПравоПримененияПатент() Экспорт
	
	// Лимит средней численности работников за налоговый период.
	// см. п. 5 ст. 346.43 НК РФ.
	Возврат 15;
	
КонецФункции

// Возвращает имя показателя "Доходы"
//
// Возвращаемое значение:
//   Строка - Имя показателя "Доходы"
//
Функция ИмяПоказателяСпецрежимаДоходы() Экспорт
	Возврат "Доходы";
КонецФункции

// Возвращает имя показателя "ОсновныеСредства"
//
// Возвращаемое значение:
//   Строка - Имя показателя "ОсновныеСредства"
//
Функция ИмяПоказателяСпецрежимаОсновныеСредства() Экспорт
	Возврат "ОсновныеСредства";
КонецФункции

// Возвращает имя показателя "Работники"
//
// Возвращаемое значение:
//   Строка - Имя показателя "Работники"
//
Функция ИмяПоказателяСпецрежимаРаботники() Экспорт
	Возврат "Работники";
КонецФункции

// Возвращает имя настройки, где хранятся напоминания
//
// Возвращаемое значение:
//   Строка - Имя настройки
//
Функция ИмяНастройкиПравоПримененияСпецрежима() Экспорт
	Возврат "ПравоПримененияСпецрежима";
КонецФункции

Функция СсылкаНаСтатьюИТСПоПравуПримененияСпецрежима(ПрименяетсяПатент = Ложь, УтраченоПравоПрименения = Ложь, ИмяПоказателя = "")

	Если ПрименяетсяПатент Тогда
		СсылкаНаСтатьюИТС = "http://its.1c.ru/db/taxpsn#content:9:hdoc"; // Статья "Утрата права на патентную систему налогообложения"
	ИначеЕсли УтраченоПравоПрименения Тогда
		СсылкаНаСтатьюИТС = "http://its.1c.ru/db/taxusn#content:65:1"; // Статья "Налогообложение при утрате права на применение УСН"
	ИначеЕсли ИмяПоказателя = ИмяПоказателяСпецрежимаДоходы() Тогда 
		СсылкаНаСтатьюИТС = "http://its.1c.ru/db/taxusn#content:64:1:issogl2209"; // Статья "Предельный размер доходов для сохранения права на применение УСН"
	ИначеЕсли ИмяПоказателя = ИмяПоказателяСпецрежимаОсновныеСредства() Тогда
		СсылкаНаСтатьюИТС = "http://its.1c.ru/db/taxusn#content:64:1:issogl2201"; // Статья "Предельная остаточная стоимость основных средств"
	ИначеЕсли ИмяПоказателя = ИмяПоказателяСпецрежимаРаботники() Тогда
		СсылкаНаСтатьюИТС = "http://its.1c.ru/db/taxusn#content:64:1:issogl2202"; // Статья "Предельная средняя численность работников"
	Иначе
		СсылкаНаСтатьюИТС = "http://its.1c.ru/db/taxusn#content:64:1:issogl1102"; // Статья "Обязательное прекращение применения УСН"
	КонецЕсли;
	
	Возврат СсылкаНаСтатьюИТС;

КонецФункции

// Возвращает лимит средней численности работников.
//
// Возвращаемое значение:
//  Число - Граница среднесписочной численности работников, ограничивающая право применения ЕНВД.
//
Функция ГраницаСреднесписочнойЧисленностиРаботниковОграничивающаяПравоПримененияЕНВД() Экспорт
	
	// Лимит средней численности работников за налоговый период.
	// см. п. 2.3 ст. 346.26 НК РФ.
	Возврат 100;
	
КонецФункции

#КонецОбласти