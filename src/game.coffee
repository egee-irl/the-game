score = 0
scoreText
platforms
diamonds
cursors
player

game = new Phaser.Game(800, 600, Phaser.AUTO, '', {
  preload: preload,
  create: create,
  update: update
})

preload () ->
  game.load.image('sky', 'sky.png')
  game.load.image('ground', 'platform.png')
  game.load.image('diamond', 'diamond.png')
  game.load.spritesheet('woof', 'woof.png', 32, 32)

create () ->
  game.physics.startSystem(Phaser.Physics.ARCADE)
  game.add.sprite(0, 0, 'sky')

  platforms = game.add.group()
  platforms.enableBody = true

  ground = platforms.create(0, game.world.height - 64, 'ground')
  ground.scale.setTo(2, 2)
  ground.body.immovable = true

  ledge = platforms.create(400, 450, 'ground')
  ledge.body.immovable = true

  ledge = platforms.create(-75, 350, 'ground')
  ledge.body.immovable = true

  player = game.add.sprite(32, game.world.height - 150, 'woof')
  game.physics.arcade.enable(player)

  player.body.bounce.y = 0.2
  player.body.gravity.y = 800
  player.body.collideWorldBounds = true
  player.animations.add('left', [0, 1], 10, true)
  player.animations.add('right', [2, 3], 10, true)

  diamonds = game.add.group()
  diamonds.enableBody = true

  i = 0
  while i < 12
    diamond = diamonds.create(i * 70, 0, 'diamond')

    diamond.body.gravity.y = 1000
    diamond.body.bounce.y = 0.3 + Math.random() * 0.2
    i++

  scoreText = game.add.text(16, 16, '', { fontSize: '32px', fill: '#000' })
  cursors = game.input.keyboard.createCursorKeys()

update () ->
  player.body.velocity.x = 0
  game.physics.arcade.collide(player, platforms)
  game.physics.arcade.collide(diamonds, platforms)
  game.physics.arcade.overlap(player, diamonds, collectDiamond, null, this)

  if cursors.left.isDown
    player.body.velocity.x = -150
    player.animations.play('left')
  else if cusors.right.isDown
    player.body.velocity.x = 150
    player.animations.play('right')
  else
    player.animations.stop()
  
  if cusrors.up.isDown && player.body.touching.down
    player.body.velocity.y = -400
  
  if score == 120
    alert "You Win"
    score = 0

collectDiamond () ->
  diamond.kill()
  score += 10
  scoreText.text = 'Score: ' + score
