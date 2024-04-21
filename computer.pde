
class Computer {
    boolean isFirst = true;

    void computer_create_style(PretransformParameters currentPretransformParameters) {
        strokeWeight(2);
        /**data will be realocated. This is pretransformed. **/
        Description descriptive = new Description(); 
        // DataResult dataResult = descriptive.read_data(seed); 
        DataResult dataResult = descriptive.read_global_feature(seed, currentPretransformParameters);
        
        /**style allocation is required. Should be predesignated by conditions**/
        Style style = new StyleMappingTable(dataResult).generateStyle(currentPretransformParameters);
        shapeDatabase.addStyle(style, globalStage);
    }
}


    