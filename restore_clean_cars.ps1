$brainDir = "C:\Users\ACER\.gemini\antigravity-ide\brain\a1e8a001-f417-4e58-94c4-4797bdd847d9"
$assetsDir = "c:\Users\ACER\.gemini\antigravity-ide\scratch\rental-mobil-lux\assets"

Copy-Item "$brainDir\innova_zenix_hybrid_1791343499689.jpg" "$assetsDir\toyota-innova-zenix.jpg" -Force
Copy-Item "$brainDir\toyota_rush_gr_1791343519918.jpg" "$assetsDir\toyota-rush.jpg" -Force
Copy-Item "$brainDir\pajero_sport_dakar_1791343550196.jpg" "$assetsDir\mitsubishi-pajero-sport.jpg" -Force
Copy-Item "$brainDir\toyota_fortuner_gr_1791343568202.jpg" "$assetsDir\toyota-fortuner.jpg" -Force
Copy-Item "$brainDir\toyota_alphard_transformer_1791343593205.jpg" "$assetsDir\toyota-alphard.jpg" -Force
Copy-Item "$brainDir\toyota_hiace_premio_1791343630862.jpg" "$assetsDir\toyota-hiace-premio.jpg" -Force

# Avanza 2016 clean base
Copy-Item "$assetsDir\toyota-avanza-2016-base.jpg" "$assetsDir\toyota-avanza-2016.jpg" -Force

# Reborn original clean at Tugu
Copy-Item "$assetsDir\hero-innova-reborn.jpg" "$assetsDir\toyota-innova-reborn.jpg" -Force

Write-Output "All 8 fleet images successfully restored to clean natural originals!"
