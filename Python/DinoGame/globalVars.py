import pygame
from items import *

pygame.init()

display_width=800
display_height=600
display=pygame.display.set_mode((display_width,display_height))
pygame.display.set_caption("Run!")


pygame.mixer.music.set_volume(0.47)
bullet_img=pygame.transform.scale(bullet_img,(30,9))
health_img=pygame.transform.scale(health_img,(30,30))
cactus_options=[69,449,37,410,40,420]
img_counter=0
scores=0
max_above=0
max_scores=0
usr_width=60
usr_height=100
usr_x=display_width //2.5
usr_y=display_height-usr_height-100
make_jump=False
jump_counter=30
health =2
cooldown=0
mouse_counter=0
need_draw_click=False
clock=pygame.time.Clock()
