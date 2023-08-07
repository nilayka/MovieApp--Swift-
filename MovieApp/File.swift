//
//  File.swift
//  MovieApp
//
//  Created by Nilay KADİROĞULLARI on 27.07.2023.
//

//import Foundation
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   BetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BetCell"];
//
//   Bet *bet = [self.bets objectAtIndex:([self.bets count]-indexPath.row-1)];
//   cell.BFNeedLabel.text = bet.BFNeeded;
//
//   if (indexPath.row != 0) {
//   UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDetected:)];
//   swipeRecognizer.direction = (UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight);
//   [cell addGestureRecognizer:swipeRecognizer];
//   }
//
//   return cell;
//
//}
//
//-(void)swipeDetected:(UIGestureRecognizer *)sender
//{
//   UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Info" message:@"You can only delete starting from the top cell" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//   [alert show];
//}
//
//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   if (indexPath.row == 0) {
//       return YES;
//   } else  {
//       return NO;
//   }
//}
//
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   // If the very first row
//   if ((editingStyle == UITableViewCellEditingStyleDelete) && (indexPath.row == 0)) {
//       Bet *betObj = [self.bets objectAtIndex:([self.bets count]-indexPath.row-1)];
//       //Delete from array
//       [self.bets removeObjectAtIndex:([self.bets count]-indexPath.row-1)];
//       //Delete the row
//       [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//
//       //Attempt to remove gesture recognizer from cell 0
//       UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDetected:)];
//       swipeRecognizer.direction = (UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight);
//       [[tableView cellForRowAtIndexPath:0]removeGestureRecognizer:swipeRecognizer];
//   }
//}
