import 'package:flutter/material.dart';


class SliderModel{

  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath,this.title,this.desc});

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}


List<SliderModel> getSlides(){

  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("We use Electronic Weighing Machine for Scrap Collection.");
  sliderModel.setTitle("No Cheating on Weights");
  sliderModel.setImageAssetPath("assets/jlogo.png", );
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("Our Rates our transparent and always displayed on our Website and Apps.");
  sliderModel.setTitle("No Cheating on Rates");
  sliderModel.setImageAssetPath("assets/1stscreen.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("We pay Instant cash on Scrap Pickup");
  sliderModel.setTitle("Instant Cash on Pickup");
  sliderModel.setImageAssetPath("assets/jlogo.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}