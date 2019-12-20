import pygame
pygame.init()

bullet_sound=pygame.mixer.Sound('shot.wav')
jump_sound=pygame.mixer.Sound('jump.wav')
fall_sound=pygame.mixer.Sound('Bdish.wav')
loss_sound=pygame.mixer.Sound('loss.wav')
heart_plus_sound= pygame.mixer.Sound('hp+.wav')
pygame.mixer.music.load('background.mp3')
cactus_img=[pygame.image.load('Cactus00.png'),
            pygame.image.load('Cactus11.png'),pygame.image.load('Cactus22.png')]
stone_img=[pygame.image.load('Stone0.png'),pygame.image.load('Stone1.png')]
cloud_img=[pygame.image.load('Cloud0.png'),pygame.image.load('Cloud1.png')]
dino_img=[pygame.image.load('Dino0.png'),pygame.image.load('Dino1.png'),
          pygame.image.load('Dino2.png'),pygame.image.load('Dino3.png'),
          pygame.image.load('Dino4.png')]
bird_img=[pygame.image.load('Bird0.png'),pygame.image.load('Bird1.png'),
          pygame.image.load('Bird2.png'),pygame.image.load('Bird3.png'),
          pygame.image.load('Bird4.png'),pygame.image.load('Bird5.png')]
light_img=[pygame.image.load('Light0.png'),pygame.image.load('Light1.png'),
          pygame.image.load('Light2.png'),pygame.image.load('Light3.png'),
          pygame.image.load('Light4.png'),pygame.image.load('Light5.png'),
           pygame.image.load('Light6.png'),pygame.image.load('Light7.png'),
          pygame.image.load('Light8.png'),pygame.image.load('Light9.png'),
          pygame.image.load('Light10.png')]
health_img=pygame.image.load('heart.png')
bullet_img=pygame.image.load('shot.png')
