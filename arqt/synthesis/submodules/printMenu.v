module printMenu (
    input wire clk_in,                                             // Clock base (vindo da placa)
    input wire enablePong,
    input wire clk_en,                                             // Clock para habilitar a instrução customizada
    input wire i_rst,                                              // Reset: recomeça a imprimir o quadro
    input wire o_active,                                           // Alto quando um pixel está sendo desenhado
    input wire [9:0] o_x,                                          // Posição x atual do pixel
    input wire [8:0] o_y,                                          // Posição y atual do pixel
    output reg color                                               // Indica se está imprimindo ou não (1 imprimindo, 0 não)
);


reg cor;                                                           // Fio auxiliar para manipular o valor do registrador color

always @(posedge clk_in) begin                                     // A cada pulso de clock
    color <= cor;                                                  // O valor do fio 'cor' é armazenado no registrador 'color'
end

always @(*) begin
    if((o_active == 1) && (enablePong == 0)) begin                                             // Caso esteja na área ativa
// Letra P
    //   Traço horizontal superior
    if((o_y >= 195 && o_y <= 205 && o_x >= 195 && o_x <= 250)) cor = 1;
    //   Traço vertical maior
    else if(o_y >= 195 && o_y <= 285 && o_x >= 195 && o_x <= 205) cor = 1;
    //   Traço vertical menor
    else if(o_y >= 235 && o_y <= 245 && o_x >= 195 && o_x <= 250) cor = 1;
    //   Traço horizontal inferior
    else if(o_y >= 195 && o_y <= 245 && o_x >= 240 && o_x <= 250) cor = 1;

// Letra O
    //   Traço vertical da esquerda
    else if((o_y >= 195 && o_y <= 285 && o_x >= 260 && o_x <= 270)) cor = 1;
    //   Traço horizontal superior
    else if(o_y >= 195 && o_y <= 205 && o_x >= 260 && o_x <= 315) cor = 1;
    //   Traço vertical da direita
    else if(o_y >= 195 && o_y <= 285 && o_x >= 305 && o_x <= 315) cor = 1;
    //   Traço horizontal inferior
    else if(o_y >= 275 && o_y <= 285 && o_x >= 260 && o_x <= 315) cor = 1;

// Letra N
    //   Traço vertical da esquerda
    else if((o_y >= 195 && o_y <= 285 && o_x >= 325 && o_x <= 335)) cor = 1;
    //  Traço inclinado:             Dividido nos próximos 45
    else if((o_y >= 195 && o_y <= 197 && o_x >= 325 && o_x <= 335)) cor = 1;
    else if((o_y >= 197 && o_y <= 199 && o_x >= 326 && o_x <= 336)) cor = 1;
    else if((o_y >= 199 && o_y <= 201 && o_x >= 327 && o_x <= 337)) cor = 1;
    else if((o_y >= 201 && o_y <= 203 && o_x >= 328 && o_x <= 338)) cor = 1;
    else if((o_y >= 203 && o_y <= 205 && o_x >= 329 && o_x <= 339)) cor = 1;
    else if((o_y >= 205 && o_y <= 207 && o_x >= 330 && o_x <= 340)) cor = 1;
    else if((o_y >= 207 && o_y <= 209 && o_x >= 331 && o_x <= 341)) cor = 1;
    else if((o_y >= 209 && o_y <= 211 && o_x >= 332 && o_x <= 342)) cor = 1;
    else if((o_y >= 211 && o_y <= 213 && o_x >= 333 && o_x <= 343)) cor = 1;
    else if((o_y >= 213 && o_y <= 215 && o_x >= 334 && o_x <= 344)) cor = 1;
    else if((o_y >= 215 && o_y <= 217 && o_x >= 335 && o_x <= 345)) cor = 1;
    else if((o_y >= 217 && o_y <= 219 && o_x >= 336 && o_x <= 346)) cor = 1;
    else if((o_y >= 219 && o_y <= 221 && o_x >= 337 && o_x <= 347)) cor = 1;
    else if((o_y >= 221 && o_y <= 223 && o_x >= 338 && o_x <= 348)) cor = 1;
    else if((o_y >= 223 && o_y <= 225 && o_x >= 339 && o_x <= 349)) cor = 1;
    else if((o_y >= 225 && o_y <= 227 && o_x >= 340 && o_x <= 350)) cor = 1;
    else if((o_y >= 227 && o_y <= 229 && o_x >= 341 && o_x <= 351)) cor = 1;
    else if((o_y >= 229 && o_y <= 231 && o_x >= 342 && o_x <= 352)) cor = 1;
    else if((o_y >= 231 && o_y <= 233 && o_x >= 343 && o_x <= 353)) cor = 1;
    else if((o_y >= 233 && o_y <= 235 && o_x >= 344 && o_x <= 354)) cor = 1;
    else if((o_y >= 235 && o_y <= 237 && o_x >= 345 && o_x <= 355)) cor = 1;
    else if((o_y >= 237 && o_y <= 239 && o_x >= 346 && o_x <= 356)) cor = 1;
    else if((o_y >= 239 && o_y <= 241 && o_x >= 347 && o_x <= 357)) cor = 1;
    else if((o_y >= 241 && o_y <= 243 && o_x >= 348 && o_x <= 358)) cor = 1;
    else if((o_y >= 243 && o_y <= 245 && o_x >= 349 && o_x <= 359)) cor = 1;
    else if((o_y >= 245 && o_y <= 247 && o_x >= 350 && o_x <= 360)) cor = 1;
    else if((o_y >= 247 && o_y <= 249 && o_x >= 351 && o_x <= 361)) cor = 1;
    else if((o_y >= 249 && o_y <= 251 && o_x >= 352 && o_x <= 362)) cor = 1;
    else if((o_y >= 251 && o_y <= 253 && o_x >= 353 && o_x <= 363)) cor = 1;
    else if((o_y >= 253 && o_y <= 255 && o_x >= 354 && o_x <= 364)) cor = 1;
    else if((o_y >= 255 && o_y <= 257 && o_x >= 355 && o_x <= 365)) cor = 1;
    else if((o_y >= 257 && o_y <= 259 && o_x >= 356 && o_x <= 366)) cor = 1;
    else if((o_y >= 259 && o_y <= 261 && o_x >= 357 && o_x <= 367)) cor = 1;
    else if((o_y >= 261 && o_y <= 263 && o_x >= 358 && o_x <= 368)) cor = 1;
    else if((o_y >= 263 && o_y <= 265 && o_x >= 359 && o_x <= 369)) cor = 1;
    else if((o_y >= 265 && o_y <= 267 && o_x >= 360 && o_x <= 370)) cor = 1;
    else if((o_y >= 267 && o_y <= 269 && o_x >= 361 && o_x <= 371)) cor = 1;
    else if((o_y >= 269 && o_y <= 271 && o_x >= 362 && o_x <= 372)) cor = 1;
    else if((o_y >= 271 && o_y <= 273 && o_x >= 363 && o_x <= 373)) cor = 1;
    else if((o_y >= 273 && o_y <= 275 && o_x >= 365 && o_x <= 374)) cor = 1;
    else if((o_y >= 275 && o_y <= 277 && o_x >= 365 && o_x <= 375)) cor = 1;
    else if((o_y >= 277 && o_y <= 279 && o_x >= 366 && o_x <= 376)) cor = 1;
    else if((o_y >= 279 && o_y <= 281 && o_x >= 367 && o_x <= 377)) cor = 1;
    else if((o_y >= 281 && o_y <= 283 && o_x >= 368 && o_x <= 378)) cor = 1;
    else if((o_y >= 283 && o_y <= 285 && o_x >= 369 && o_x <= 379)) cor = 1;
    else if((o_y >= 285 && o_y <= 287 && o_x >= 370 && o_x <= 380)) cor = 1;
    //   Traço inclinado
    else if(o_y >= 195 && o_y <= 285 && o_x >= 370 && o_x <= 380) cor = 1;

// Letra G
    //   Traço horizontal superior
    else if((o_y >= 195 && o_y <= 205 && o_x >= 390 && o_x <= 445)) cor = 1;
    //   Traço horizontal inferior
    else if((o_y >= 275 && o_y <= 285 && o_x >= 390 && o_x <= 445)) cor = 1;
    //   Traço horizontal menor
    else if((o_y >= 235 && o_y <= 245 && o_x >= 425 && o_x <= 445)) cor = 1;
    //   Traço vertical esquerdo
    else if((o_y >= 195 && o_y <= 285 && o_x >= 390 && o_x <= 400)) cor = 1;
    //   Traço vertical direito
    else if((o_y >= 235 && o_y <= 285 && o_x >= 435 && o_x <= 445)) cor = 1;

//////////////////////////////////////////////////////////////////////////////

// Letra P
    //   Traço horizontal inferior
//    else if((o_y >= 415 && o_y <= 420 && o_x >= 195 && o_x <= 222)) cor = 1;
    //   Traço vertical maior
//    else if(o_y >= 395 && o_y <= 440 && o_x >= 195 && o_x <= 200) cor = 1;
    //   Traço vertical menor
//    else if(o_y >= 395 && o_y <= 420 && o_x >= 217 && o_x <= 222) cor = 1;
    //   Traço horizontal superior
//    else if(o_y >= 395 && o_y <= 400 && o_x >= 195 && o_x <= 222) cor = 1;

// Letra R
    //   Traço horizontal inferior
//    else if((o_y >= 420 && o_y <= 425 && o_x >= 232 && o_x <= 259)) cor = 1;
    //   Traço vertical maior
//    else if(o_y >= 395 && o_y <= 440 && o_x >= 232 && o_x <= 237) cor = 1;
    //   Traço vertical menor
//    else if(o_y >= 395 && o_y <= 425 && o_x >= 254 && o_x <= 259) cor = 1;
    //   Traço horizontal superior
//    else if(o_y >= 395 && o_y <= 400 && o_x >= 232 && o_x <= 259) cor = 1;
    //   Traço inclinado: vai de y = 425 a y = 440 e de x = 244 até x = 259
//    else if(o_y >= 425 && o_y <= 426 && o_x >= 244 && o_x <= 249) cor = 1;
//    else if(o_y >= 426 && o_y <= 427 && o_x >= 245 && o_x <= 250) cor = 1;
//    else if(o_y >= 427 && o_y <= 428 && o_x >= 246 && o_x <= 251) cor = 1;
//    else if(o_y >= 428 && o_y <= 429 && o_x >= 247 && o_x <= 252) cor = 1;
//    else if(o_y >= 429 && o_y <= 430 && o_x >= 248 && o_x <= 253) cor = 1;
//    else if(o_y >= 430 && o_y <= 431 && o_x >= 249 && o_x <= 254) cor = 1;
//    else if(o_y >= 431 && o_y <= 432 && o_x >= 250 && o_x <= 255) cor = 1;
//    else if(o_y >= 432 && o_y <= 433 && o_x >= 251 && o_x <= 256) cor = 1;
//    else if(o_y >= 433 && o_y <= 434 && o_x >= 252 && o_x <= 257) cor = 1;
//    else if(o_y >= 434 && o_y <= 435 && o_x >= 253 && o_x <= 258) cor = 1;
//    else if(o_y >= 435 && o_y <= 436 && o_x >= 254 && o_x <= 259) cor = 1;
//    else if(o_y >= 436 && o_y <= 437 && o_x >= 255 && o_x <= 260) cor = 1;
//    else if(o_y >= 437 && o_y <= 438 && o_x >= 256 && o_x <= 261) cor = 1;
//    else if(o_y >= 438 && o_y <= 439 && o_x >= 257 && o_x <= 262) cor = 1;
//    else if(o_y >= 439 && o_y <= 440 && o_x >= 258 && o_x <= 263) cor = 1;

// Letra E
    //   Traço horizontal inferior
//    else if((o_y >= 435 && o_y <= 440 && o_x >= 269 && o_x <= 296)) cor = 1;
    //   Traço vertical maior
//    else if(o_y >= 395 && o_y <= 440 && o_x >= 269 && o_x <= 274) cor = 1;
    //   Traço horizontal superior
//    else if(o_y >= 395 && o_y <= 400 && o_x >= 269 && o_x <= 296) cor = 1;
    //   Traço do meio
//    else if(o_y >= 415 && o_y <= 420 && o_x >= 269 && o_x <= 296) cor = 1;

// Letra S
    //   Traço horizontal superior
//    else if(o_y >= 395 && o_y <= 400 && o_x >= 306 && o_x <= 333) cor = 1;
    //   Primeiro traço vertical
//    else if(o_y >= 395 && o_y <= 415 && o_x >= 306 && o_x <= 311) cor = 1;
    //   Traço horizontal do meio
//    else if((o_y >= 410 && o_y <= 415 && o_x >= 306 && o_x <= 333)) cor = 1;
    //   Segundo traço vertical
//    else if(o_y >= 410 && o_y <= 435 && o_x >= 328 && o_x <= 333) cor = 1;
    //   Traço horizontal inferior
//    else if(o_y >= 435 && o_y <= 440 && o_x >= 306 && o_x <= 333) cor = 1;

// Letra S
    //   Traço horizontal superior
//    else if(o_y >= 395 && o_y <= 400 && o_x >= 343 && o_x <= 350) cor = 1;
    //   Primeiro traço vertical
//    else if(o_y >= 395 && o_y <= 415 && o_x >= 343 && o_x <= 348) cor = 1;
    //   Traço horizontal do meio
//    else if((o_y >= 410 && o_y <= 415 && o_x >= 343 && o_x <= 370)) cor = 1;
    //   Segundo traço vertical
//    else if(o_y >= 410 && o_y <= 435 && o_x >= 365 && o_x <= 370) cor = 1;
    //   Traço horizontal inferior
//    else if(o_y >= 435 && o_y <= 440 && o_x >= 343 && o_x <= 370) cor = 1;

// Letra S
    //   Traço horizontal superior
//    else if(o_y >= 395 && o_y <= 400 && o_x >= 336 && o_x <= 363) cor = 1;
    //   Primeiro traço vertical
  //  else if(o_y >= 395 && o_y <= 415 && o_x >= 336 && o_x <= 341) cor = 1;
    //   Traço horizontal do meio
    //else if((o_y >= 410 && o_y <= 415 && o_x >= 336 && o_x <= 363)) cor = 1;
    //   Segundo traço vertical
//    else if(o_y >= 410 && o_y <= 435 && o_x >= 358 && o_x <= 363) cor = 1;
    //   Traço horizontal inferior
  //  else if(o_y >= 435 && o_y <= 440 && o_x >= 336 && o_x <= 363) cor = 1;

// Letra T
    //   Traço horizontal superior
  //  else if(o_y >= 395 && o_y <= 400 && o_x >= 373 && o_x <= 400) cor = 1;
    //   Traço vertical
  //  else if(o_y >= 395 && o_y <= 440 && o_x >= 381 && o_x <= 386) cor = 1;

    else cor = 0;
    end
    else cor = 0;
end
endmodule
