/**
 * @file generateArtifactTable.cpp
 * @author hyperhraph
 * @brief A small tool to generate all possible artifact substat combinations
 * @version 0.1
 * @date 2022-02-27
 * 
 * @copyright Copyright (c) 2022
 * 
 */

#include<iostream>
#include<vector>
#define ARTI_TYPE float

/**
 * @brief The enum for all possible statType, same name with Dimbreath/GenshinData/ExcelBinOutput/ReliquaryAffixExcelConfigData.json
 * 
 */
enum statType {hp, hp_percent, attack, attack_percent, defence, defence_percent, charge_efficiency, element_mastery, critical, critical_hurt};

/**
 * @brief Data from Dimbreath/GenshinData
 * 
 */
const ARTI_TYPE r5[10][4]={
    {209.13,239.0,268.88,298.75},      //hp
    {0.0408,0.0466,0.0525,0.0583},     //hp_percent
    {13.62,15.56,17.51,19.45},         //attack
    {0.0408,0.0466,0.0525,0.0583},     //attack_percent
    {16.20,18.52,20.83,23.14},         //defence
    {0.0510,0.0583,0.0656,0.0729},     //defence_percent
    {0.0453,0.0518,0.0583,0.0648},     //charge_efficiency
    {16.32,18.65,20.98,23.31},         //element_mastery
    {0.0272,0.0311,0.0350,0.0389},     //critical
    {0.0544,0.0622,0.0699,0.0777},     //critical_hurt
};

