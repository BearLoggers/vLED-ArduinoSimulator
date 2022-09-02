// Кастомный обработчик уведомлений на экране
MessageBoxManager messageBoxManager = new MessageBoxManager();
// Читает конфигурацию из файла и позволяет читать её в любом месте программы
ConfigurationReader configuration;
// Отрисовщик виртуального экрана для симуляции
VirtualScreenDrawer vScreenDrawer;
// Класс, который может отображать простые тултипы вокруг курсора
TooltipDrawer tooltipDrawer = new TooltipDrawer();
// Класс, который умеет преобразовывать пиксели на экране в см и см в пиксели
VirtualCoordinatesMapper virtualCoordsMaper;

/*** Глобальные переменные для ведения симуляции ***/
/*int virtualScreenWidthPx;
int virtualScreenHeightPx;*/

void setup() {
    // Создаём окно с дефолтным размером
    size(1280, 720);
    // Разрешаем последующее изменение размера окна
    surface.setResizable(true);
    surface.setTitle("vLED - Симулятор");
    
    // Читаем конфигурацию
    configuration = new ConfigurationReader("./Configuration/simulation.conf");
    
    // Изменяем размер окна согласно конфигурации
    int xSize = configuration.getSimScreenWidthPx();
    int ySize = (int)(xSize * (9.0 / 16.0));
    surface.setSize(configuration.getSimScreenWidthPx(), ySize);
    // Запрещаем дальнейшее изменение размера окна (включая ручное изменение размера)
    surface.setResizable(false);
    
    /**** Инициализация симулятора ****/
    // Подсчёт сколько пикселей на экране будет занимать виртуальный экран
    float virtualScreenRatio = (float)configuration.getAreaWidth() / (float)configuration.getAreaHeight();
    
    int virtualScreenWidthPx = (int)(0.9f * width);
    int virtualScreenHeightPx = (int)(virtualScreenWidthPx / virtualScreenRatio);
    
    // Инициализируем рисовщик виртуального экрана
    vScreenDrawer = new VirtualScreenDrawer(virtualScreenWidthPx, virtualScreenHeightPx);
    
    // И вместе с этим инициализируем VirtualCoordinatesMapper
    
    // Сколько пикселей нужно для одного сантиметра
    float cmToPx = (float)virtualScreenWidthPx / (float)configuration.getAreaWidth();
    virtualCoordsMaper = new VirtualCoordinatesMapper(virtualScreenWidthPx, virtualScreenHeightPx, cmToPx);
}

void draw() {
    background(255);
    
    // Отрисовка самого экрана
    vScreenDrawer.draw();
    
    
    // Обрабатываем тултипы вокруг курсора
    tooltipDrawer.draw();
    // Обрабатывает уведомления на экране, которые можно добавить вызывом messageBoxManager.create(...);
    messageBoxManager.process();
}
