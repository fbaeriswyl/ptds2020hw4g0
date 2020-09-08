make_circle = function(center = c(0,0), radius = 1,  nb_step = 300, col = "darkblue", fill = NULL, lty = 1){
  my_points = seq(from = 0, to = 2*pi, length.out = nb_step)
  coords = cbind(radius*cos(my_points) + center[1], radius*sin(my_points) + center[2])
  lines(coords, col = col, lty = lty)
  if (!is.null(fill)){
    polygon(c(coords[,1]), c(coords[,2]), col = fill, border = NULL)
  }
}

make_square = function(bottom_left = c(-1,-1), side = 2, col = "darkblue", fill = NULL){
  lines(c(bottom_left, bottom_left), c(bottom_left + side, bottom_left), col = col)
  lines(c(bottom_left + side, bottom_left), c(bottom_left + side, bottom_left + side), col = col)
  lines(c(bottom_left + side, bottom_left + side), c(bottom_left, bottom_left + side), col = col)
  lines(c(bottom_left, bottom_left + side), c(bottom_left, bottom_left), col = col)
  if (!is.null(fill)){
    polygon(c(bottom_left, bottom_left+side, bottom_left+side, bottom_left), c(bottom_left, bottom_left, bottom_left+side, bottom_left+side), border = NULL, col = fill)
  }
}

inside_unit_circle = function(x){
  # Compute squared distance from center
  d = (x[1])^2 + (x[2])^2
  (d < 1)
}

estimate_pi = function(B = 5000, seed = 10){
  # Control of the arguments
  if(B%%1 != 0 | B <= 0){
    stop("Argument B is invalid. Please specify a positive integer for this parameter.")
  }

  if(seed%%1 != 0 | seed <= 0){
    stop("seed argument is invalid. Please specify a positive integer for this parameter.")
  }


  # Control seed
  set.seed(seed)

  # Simulate B points
  points <- data.frame(
    x = runif(n = B, min = -1, max = 1),
    y = runif(n = B, min = -1, max = 1),
    inside = rep(NA, B)
  )

  points$inside = ifelse(apply(cbind(points$x, points$y), 1, inside_unit_circle)==TRUE, 1, 0)

  # Compute the number of points inside unit circle
  nb_inside = apply(points, 1, inside_unit_circle)
  estimated_pi = 4*(sum(nb_inside)/B)

  # create a new list
  rval <- list(
    estimated_pi = estimated_pi,
    points = points
  )

  # assign pi class to rval
  class(rval) <- "pi"

  # return rval
  return(rval)
}

plot.pi <- function(x){
  #Control of the argument
  if(class(x) != "pi"){
    stop("Specify an argument of the pi class for this function. ")
  }

  points <- x[["points"]]
  B <- nrow(points)

  plot(NA, xlim = c(-1.1,1.1), ylim = c(-1.1,1.1), xlab = "x", ylab = "y")
  make_square()
  cols = hcl(h = seq(15, 375, length = 3), l = 65, c = 100, alpha = 0.2)[1:2]
  grid()
  for (i in 1:B){
    points(points[i,1], points[i,2], pch = 16, col = cols[1 + nb_inside[i]])
  }
  make_circle()
}