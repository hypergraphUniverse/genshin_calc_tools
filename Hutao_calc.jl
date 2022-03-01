# This is a high-precision numeric Simulation on my own Hutao.
using Printf

# White Number Section
# Hutao LV90
# Weapon Pole_Gladiator LV80/LV90
# Data are collected in Dimbreath/GenshinData
Char_HP_Base=Float32(1210.7164)
Char_ATK_Base=Float32(8.2859)
Char_DEF_Base=Float32(68.2062)

Char_Mul=Float32(8.739)

Char_HP_Promo=Float32(4971.8560)
Char_ATK_Promo=Float32(34.0239)
Char_DEF_Promo=Float32(280.0980)

Weap_ATK_Base=Float32(41.0671)
Weap_CRIT_Base=Float32(0.08)

Weap_ATK_Mul=Float32(6.5980)
Weap_CRIT_Mul=Float32(4.1900)

Weap_ATK_Promo=Float32(155.60)

HP_White=Char_HP_Base*Char_Mul+Char_HP_Promo
ATK_White=Char_ATK_Base*Char_Mul+Char_ATK_Promo+Weap_ATK_Base*Weap_ATK_Mul+Weap_ATK_Promo
DEF_White=Char_DEF_Base*Char_Mul+Char_DEF_Promo

@printf("Hutao Simulation:\n")

@printf("HP White:%.0f\t%f\n",HP_White,HP_White)
@printf("ATK White:%.0f\t%f\n",ATK_White,ATK_White)
@printf("DEF White:%.0f\t%f\n\n",DEF_White,DEF_White)

# Which could be seen that is perfectly matched with original Data

extern_HP_mul=1f0+ 0.0408f0 + 0.0408f0 + 0.1458f0 #可能是0.1457/0.1458 经过验证，是后者
extern_HP_add=4780f0

extern_ATK_mul=1f0+0.0466f0+0.0874f0+0.24f0+0.18f0 #最后两者是决斗枪+二件套
extern_ATK_add=15.56f0+311f0

extern_DEF_mul=1f0
extern_DEF_add=18.52f0+60.17f0+34.72f0 #60.17/60.18 两者效果一致

HP_tot=HP_White*extern_HP_mul+extern_HP_add
ATK_tot=ATK_White*extern_ATK_mul+extern_ATK_add
DEF_tot=DEF_White*extern_DEF_mul+extern_DEF_add

@printf("HP Total:%.0f\t%f\n",HP_tot,HP_tot)
@printf("ATK Total:%.0f\t%f\n",ATK_tot,ATK_tot)
@printf("DEF Total:%.0f\t%f\n\n",DEF_tot,DEF_tot)

@printf("ATK during E:%.0f\t%f\n",ATK_tot+HP_tot*0.0596f0,ATK_tot+HP_tot*0.0596f0)