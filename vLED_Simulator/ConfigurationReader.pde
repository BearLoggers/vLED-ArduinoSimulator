class ConfigurationReader {
    private String _version = "1.0.0"; 
  
    // Создаёт экземпляр ConfigurationReader и сразу же инициализирует нужные переменные для чтения
    public ConfigurationReader(String filePath) {
        IS_SUCCESSFUL = readConfiguration(filePath);
    }
    
    // Читает конфигурацию из файла. Если всё успешно, то возвращает true, иначе false
    private boolean readConfiguration(String filePath) {
        BufferedReader reader = createReader(filePath);
        String line = null;
     
        try {
            // Читаем строчка за строчкой
            while ((line = reader.readLine()) != null) {
                // Срезаем лишние потенциальные пробелы/табы в начале и в конце
                line = trim(line);
                
                // Если строчка была пустой - пропускаем
                if (line.length() == 0) continue;
                // Если строчка начинается с "#" - это комментарий, пропускаем
                if (line.startsWith("#")) continue;
                
                // Что-то полезное, читаем
                // Формат конфигурации 'variable = value'
                String[] parts = split(line, ' ');
                
                if (parts.length != 3) {
                   messageBoxManager.create("Ошибка чтения конфигурации", "Какая-то строчка не была в формате 'переменная = значение'", 10);
                   return false;
                }
                
                switch (parts[0]) {
                    case "configuration_file_version":
                        if (!parts[2].equals(_version)) {
                            messageBoxManager.create("Предупреждение", String.format("Версия конфигурационного файла v%s, а программа принимает v%s", parts[2], _version), 12);
                        }
                        break;
                    case "led_strip_length":
                        _ledStripLength = convertIntOrDefault(parts[2], 240, parts[0], true);
                        break;
                    case "led_density_per_m":
                        _ledDensityPerM = convertIntOrDefault(parts[2], 60, parts[0], true);
                        break;
                    case "area_height":
                        _areaHeight = convertIntOrDefault(parts[2], 63, parts[0], true);
                        break;
                    case "area_width":
                        _areaWidth = convertIntOrDefault(parts[2], 112, parts[0], true);
                        break;
                    case "area_padding":
                        _areaPadding = convertIntOrDefault(parts[2], 3, parts[0], true);
                        break;
                    case "sim_screen_width_px":
                        _simScreenWidthPx = convertIntOrDefault(parts[2], 1000, parts[0], true);
                        break;
                        
                    default:
                        messageBoxManager.create(
                            String.format("Предупреждение", parts[2]), 
                            String.format("Неизвестный параметр '%s' в конфигурации", parts[0]));
                        break;
                }
            }
            reader.close();
        }
        catch (IOException e) {
            e.printStackTrace();
            return false;
        }
        
        return true;
    }
    
    private int convertIntOrDefault(String str, int defaultValue, String valueName, boolean showErrorOnScreen) {
        int result;
        try {
           result = Integer.parseInt(str);
        }
        catch (NumberFormatException e) {
           result = defaultValue;
           if (showErrorOnScreen) {
               messageBoxManager.create(
                   String.format("Ошибка конвертации '%s'", valueName), 
                   String.format("Значение из конфигурации '%s' не удалось преобразовать (взято значение %d)", str, defaultValue));
           }
        }
        
        return result;
    }
    
    public final boolean IS_SUCCESSFUL;  
  
    // Длина ленты (в см)
    private int _ledStripLength = 0;
    // Плотность светодиодов (в светодиодах на м)
    private int _ledDensityPerM = 0;
    // Высота покрываемой прямоугольной зоны (в см)
    private int _areaHeight = 0;
    // Ширина покрываемой прямоугольной зоны (в см)
    private int _areaWidth = 0;
    // Отступ от края прямоугольной зоны (в см)
    private int _areaPadding = 0;
  
    // Разрешение экрана (ширина) (в пикселях)
    private int _simScreenWidthPx = 1000;
    
    // Геттеры
    public int getLedStripLength() { return _ledStripLength; }
    public int getLedDensityPerM() { return _ledDensityPerM; }
    public int getAreaHeight() { return _areaHeight; }
    public int getAreaWidth() { return _areaWidth; }
    public int getAreaPadding() { return _areaPadding; }
    public int getSimScreenWidthPx() { return _simScreenWidthPx; }
}
